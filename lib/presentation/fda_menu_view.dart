import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaMenuView extends StatefulWidget {
  const FdaMenuView({super.key});

  @override
  State<FdaMenuView> createState() => _FdaMenuViewState();
}

class _FdaMenuViewState extends State<FdaMenuView> {
  String selectedCategory = "All";
  int cartItemCount = 0;
  
  final List<Map<String, dynamic>> categories = [
    {"name": "All", "count": 24},
    {"name": "Popular", "count": 8},
    {"name": "Appetizers", "count": 6},
    {"name": "Main Course", "count": 10},
    {"name": "Desserts", "count": 4},
    {"name": "Beverages", "count": 6},
  ];

  final List<Map<String, dynamic>> menuItems = [
    {
      "id": 1,
      "name": "Margherita Pizza",
      "description": "Fresh tomato sauce, mozzarella cheese, basil leaves",
      "price": 16.99,
      "originalPrice": 19.99,
      "image": "https://picsum.photos/150/150?random=80&keyword=pizza",
      "category": "Main Course",
      "isVeg": true,
      "isSpicy": false,
      "rating": 4.8,
      "preparationTime": "15-20 min",
      "calories": 320,
      "isPopular": true,
      "discount": 15,
      "tags": ["Best Seller", "Chef's Special"],
    },
    {
      "id": 2,
      "name": "Chicken Alfredo Pasta",
      "description": "Creamy alfredo sauce with grilled chicken and fettuccine",
      "price": 18.99,
      "originalPrice": null,
      "image": "https://picsum.photos/150/150?random=81&keyword=pasta",
      "category": "Main Course",
      "isVeg": false,
      "isSpicy": false,
      "rating": 4.7,
      "preparationTime": "20-25 min",
      "calories": 450,
      "isPopular": true,
      "discount": 0,
      "tags": ["High Protein"],
    },
    {
      "id": 3,
      "name": "Caesar Salad",
      "description": "Romaine lettuce, parmesan cheese, croutons, caesar dressing",
      "price": 12.99,
      "originalPrice": null,
      "image": "https://picsum.photos/150/150?random=82&keyword=salad",
      "category": "Appetizers",
      "isVeg": true,
      "isSpicy": false,
      "rating": 4.5,
      "preparationTime": "10-15 min",
      "calories": 180,
      "isPopular": false,
      "discount": 0,
      "tags": ["Light", "Healthy"],
    },
    {
      "id": 4,
      "name": "Spicy Chicken Wings",
      "description": "Buffalo style chicken wings with blue cheese dipping sauce",
      "price": 14.99,
      "originalPrice": 17.99,
      "image": "https://picsum.photos/150/150?random=83&keyword=wings",
      "category": "Appetizers",
      "isVeg": false,
      "isSpicy": true,
      "rating": 4.6,
      "preparationTime": "15-20 min",
      "calories": 380,
      "isPopular": true,
      "discount": 17,
      "tags": ["Spicy", "Popular"],
    },
    {
      "id": 5,
      "name": "Chocolate Brownie",
      "description": "Rich chocolate brownie with vanilla ice cream",
      "price": 8.99,
      "originalPrice": null,
      "image": "https://picsum.photos/150/150?random=84&keyword=brownie",
      "category": "Desserts",
      "isVeg": true,
      "isSpicy": false,
      "rating": 4.9,
      "preparationTime": "5-10 min",
      "calories": 420,
      "isPopular": false,
      "discount": 0,
      "tags": ["Sweet", "Classic"],
    },
    {
      "id": 6,
      "name": "Fresh Orange Juice",
      "description": "Freshly squeezed orange juice with pulp",
      "price": 4.99,
      "originalPrice": null,
      "image": "https://picsum.photos/150/150?random=85&keyword=juice",
      "category": "Beverages",
      "isVeg": true,
      "isSpicy": false,
      "rating": 4.4,
      "preparationTime": "5 min",
      "calories": 120,
      "isPopular": false,
      "discount": 0,
      "tags": ["Fresh", "Vitamin C"],
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    if (selectedCategory == "All") {
      return menuItems;
    } else if (selectedCategory == "Popular") {
      return menuItems.where((item) => item["isPopular"] == true).toList();
    } else {
      return menuItems.where((item) => item["category"] == selectedCategory).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () async {
                  
                },
              ),
              if (cartItemCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      cartItemCount.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            height: 60,
            child: QCategoryPicker(
              items: categories.map((cat) => {
                "label": "${cat["name"]} (${cat["count"]})",
                "value": cat["name"],
              }).toList(),
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
          ),
          
          // Search Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: GestureDetector(
              onTap: () async {
                
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spMd),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: disabledBoldColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Search menu items...",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.tune, color: disabledBoldColor, size: 20),
                  ],
                ),
              ),
            ),
          ),

          // Menu Items List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  child: GestureDetector(
                    onTap: () async {
                      
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Food Image
                          Stack(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusMd),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusMd),
                                  child: Image.network(
                                    "${item["image"]}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              if ((item["discount"] as int) > 0)
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(radiusMd),
                                        bottomRight: Radius.circular(radiusSm),
                                      ),
                                    ),
                                    child: Text(
                                      "${item["discount"]}% OFF",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              Positioned(
                                bottom: spXs,
                                right: spXs,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(150),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${item["preparationTime"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(width: spMd),
                          
                          // Food Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Food Name and Tags
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Veg/Non-veg and Spicy indicators
                                    Column(
                                      children: [
                                        Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            color: item["isVeg"] == true ? successColor : dangerColor,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        if (item["isSpicy"] == true) ...[
                                          SizedBox(height: 2),
                                          Icon(
                                            Icons.local_fire_department,
                                            size: 12,
                                            color: dangerColor,
                                          ),
                                        ],
                                      ],
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${item["name"]}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          if ((item["tags"] as List).isNotEmpty)
                                            Padding(
                                              padding: EdgeInsets.only(top: 2),
                                              child: QHorizontalScroll(
                                                children: (item["tags"] as List).map((tag) {
                                                  return Container(
                                                    margin: EdgeInsets.only(right: spXs),
                                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                                    decoration: BoxDecoration(
                                                      color: primaryColor.withAlpha(25),
                                                      borderRadius: BorderRadius.circular(radiusXs),
                                                    ),
                                                    child: Text(
                                                      "$tag",
                                                      style: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                
                                SizedBox(height: spSm),
                                
                                // Description
                                Text(
                                  "${item["description"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                    height: 1.3,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                
                                SizedBox(height: spSm),
                                
                                // Rating and Calories
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.star, size: 14, color: warningColor),
                                        SizedBox(width: 2),
                                        Text(
                                          "${item["rating"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: spMd),
                                    Text(
                                      "${item["calories"]} cal",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                
                                SizedBox(height: spSm),
                                
                                // Price and Add Button
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "\$${(item["price"] as double).toStringAsFixed(2)}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                            if (item["originalPrice"] != null) ...[
                                              SizedBox(width: spSm),
                                              Text(
                                                "\$${(item["originalPrice"] as double).toStringAsFixed(2)}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: disabledBoldColor,
                                                  decoration: TextDecoration.lineThrough,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                        if ((item["discount"] as int) > 0)
                                          Text(
                                            "Save \$${((item["originalPrice"] as double) - (item["price"] as double)).toStringAsFixed(2)}",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: successColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                      ],
                                    ),
                                    
                                    // Add to Cart Button
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(radiusMd),
                                        border: Border.all(color: primaryColor),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                            onTap: () => _decreaseQuantity(item["id"]),
                                            child: Container(
                                              width: 32,
                                              height: 32,
                                              decoration: BoxDecoration(
                                                color: primaryColor.withAlpha(25),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(radiusMd),
                                                  bottomLeft: Radius.circular(radiusMd),
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.remove,
                                                size: 16,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 40,
                                            height: 32,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "1", // This would be dynamic in real app
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => _increaseQuantity(item["id"]),
                                            child: Container(
                                              width: 32,
                                              height: 32,
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(radiusMd),
                                                  bottomRight: Radius.circular(radiusMd),
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.add,
                                                size: 16,
                                                color: Colors.white,
                                              ),
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
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _increaseQuantity(int itemId) {
    cartItemCount++;
    setState(() {});
    ss("Item added to cart");
  }

  void _decreaseQuantity(int itemId) {
    if (cartItemCount > 0) {
      cartItemCount--;
      setState(() {});
      ss("Item removed from cart");
    }
  }
}
