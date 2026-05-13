import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaMenuView extends StatefulWidget {
  const TtaMenuView({super.key});

  @override
  State<TtaMenuView> createState() => _TtaMenuViewState();
}

class _TtaMenuViewState extends State<TtaMenuView> {
  String selectedCategory = "All";
  String searchQuery = "";
  List<Map<String, dynamic>> cart = [];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Appetizers", "value": "Appetizers"},
    {"label": "Pasta", "value": "Pasta"},
    {"label": "Pizza", "value": "Pizza"},
    {"label": "Main Courses", "value": "Main Courses"},
    {"label": "Desserts", "value": "Desserts"},
    {"label": "Beverages", "value": "Beverages"},
  ];

  List<Map<String, dynamic>> menuItems = [
    {
      "id": 1,
      "name": "Caesar Salad",
      "category": "Appetizers",
      "price": 12.99,
      "description": "Fresh romaine lettuce, parmesan cheese, croutons, and classic Caesar dressing",
      "image": "https://picsum.photos/200/150?random=1&keyword=salad",
      "rating": 4.6,
      "isVegetarian": true,
      "isSpicy": false,
      "calories": 280,
      "prepTime": "10 min",
      "ingredients": ["Romaine lettuce", "Parmesan", "Croutons", "Caesar dressing"],
      "allergens": ["Dairy", "Gluten"]
    },
    {
      "id": 2,
      "name": "Bruschetta",
      "category": "Appetizers",
      "price": 9.99,
      "description": "Toasted bread topped with fresh tomatoes, basil, and garlic",
      "image": "https://picsum.photos/200/150?random=2&keyword=bruschetta",
      "rating": 4.4,
      "isVegetarian": true,
      "isSpicy": false,
      "calories": 150,
      "prepTime": "8 min",
      "ingredients": ["Bread", "Tomatoes", "Basil", "Garlic"],
      "allergens": ["Gluten"]
    },
    {
      "id": 3,
      "name": "Spaghetti Carbonara",
      "category": "Pasta",
      "price": 18.99,
      "description": "Classic Roman pasta with eggs, cheese, pancetta, and black pepper",
      "image": "https://picsum.photos/200/150?random=3&keyword=carbonara",
      "rating": 4.9,
      "isVegetarian": false,
      "isSpicy": false,
      "calories": 650,
      "prepTime": "15 min",
      "ingredients": ["Spaghetti", "Eggs", "Pancetta", "Parmesan", "Black pepper"],
      "allergens": ["Dairy", "Gluten", "Eggs"]
    },
    {
      "id": 4,
      "name": "Penne Arrabbiata",
      "category": "Pasta",
      "price": 16.99,
      "description": "Spicy tomato sauce with garlic, red chili peppers, and fresh herbs",
      "image": "https://picsum.photos/200/150?random=4&keyword=arrabbiata",
      "rating": 4.5,
      "isVegetarian": true,
      "isSpicy": true,
      "calories": 520,
      "prepTime": "12 min",
      "ingredients": ["Penne", "Tomatoes", "Garlic", "Chili peppers", "Herbs"],
      "allergens": ["Gluten"]
    },
    {
      "id": 5,
      "name": "Margherita Pizza",
      "category": "Pizza",
      "price": 16.99,
      "description": "Fresh mozzarella, tomatoes, and basil on thin crust",
      "image": "https://picsum.photos/200/150?random=5&keyword=margherita",
      "rating": 4.7,
      "isVegetarian": true,
      "isSpicy": false,
      "calories": 580,
      "prepTime": "18 min",
      "ingredients": ["Pizza dough", "Mozzarella", "Tomatoes", "Basil"],
      "allergens": ["Dairy", "Gluten"]
    },
    {
      "id": 6,
      "name": "Pepperoni Pizza",
      "category": "Pizza",
      "price": 19.99,
      "description": "Classic pepperoni with mozzarella cheese on traditional crust",
      "image": "https://picsum.photos/200/150?random=6&keyword=pepperoni",
      "rating": 4.6,
      "isVegetarian": false,
      "isSpicy": false,
      "calories": 720,
      "prepTime": "20 min",
      "ingredients": ["Pizza dough", "Mozzarella", "Pepperoni", "Tomato sauce"],
      "allergens": ["Dairy", "Gluten"]
    },
    {
      "id": 7,
      "name": "Osso Buco",
      "category": "Main Courses",
      "price": 28.99,
      "description": "Braised veal shanks with vegetables, white wine, and broth",
      "image": "https://picsum.photos/200/150?random=7&keyword=ossobuco",
      "rating": 4.8,
      "isVegetarian": false,
      "isSpicy": false,
      "calories": 850,
      "prepTime": "25 min",
      "ingredients": ["Veal shanks", "Vegetables", "White wine", "Broth"],
      "allergens": []
    },
    {
      "id": 8,
      "name": "Chicken Parmigiana",
      "category": "Main Courses",
      "price": 24.99,
      "description": "Breaded chicken breast with marinara sauce and melted cheese",
      "image": "https://picsum.photos/200/150?random=8&keyword=parmigiana",
      "rating": 4.5,
      "isVegetarian": false,
      "isSpicy": false,
      "calories": 780,
      "prepTime": "22 min",
      "ingredients": ["Chicken breast", "Breadcrumbs", "Marinara", "Mozzarella"],
      "allergens": ["Dairy", "Gluten"]
    },
    {
      "id": 9,
      "name": "Tiramisu",
      "category": "Desserts",
      "price": 8.99,
      "description": "Traditional Italian dessert with coffee, mascarpone, and cocoa",
      "image": "https://picsum.photos/200/150?random=9&keyword=tiramisu",
      "rating": 4.8,
      "isVegetarian": true,
      "isSpicy": false,
      "calories": 420,
      "prepTime": "5 min",
      "ingredients": ["Ladyfingers", "Coffee", "Mascarpone", "Cocoa", "Eggs"],
      "allergens": ["Dairy", "Gluten", "Eggs"]
    },
    {
      "id": 10,
      "name": "Espresso",
      "category": "Beverages",
      "price": 3.99,
      "description": "Rich Italian coffee served in traditional small cup",
      "image": "https://picsum.photos/200/150?random=10&keyword=espresso",
      "rating": 4.7,
      "isVegetarian": true,
      "isSpicy": false,
      "calories": 5,
      "prepTime": "3 min",
      "ingredients": ["Coffee beans"],
      "allergens": []
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    return menuItems.where((item) {
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      bool matchesSearch = "${item["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${item["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void addToCart(Map<String, dynamic> item) {
    int existingIndex = cart.indexWhere((cartItem) => cartItem["id"] == item["id"]);
    if (existingIndex >= 0) {
      cart[existingIndex]["quantity"] = (cart[existingIndex]["quantity"] as int) + 1;
    } else {
      cart.add({
        ...item,
        "quantity": 1,
      });
    }
    setState(() {});
    ss("${item["name"]} added to cart");
  }

  void removeFromCart(Map<String, dynamic> item) {
    int existingIndex = cart.indexWhere((cartItem) => cartItem["id"] == item["id"]);
    if (existingIndex >= 0) {
      if ((cart[existingIndex]["quantity"] as int) > 1) {
        cart[existingIndex]["quantity"] = (cart[existingIndex]["quantity"] as int) - 1;
      } else {
        cart.removeAt(existingIndex);
      }
      setState(() {});
    }
  }

  int getCartQuantity(Map<String, dynamic> item) {
    int existingIndex = cart.indexWhere((cartItem) => cartItem["id"] == item["id"]);
    return existingIndex >= 0 ? cart[existingIndex]["quantity"] as int : 0;
  }

  double get cartTotal {
    return cart.fold(0.0, (total, item) => 
        total + ((item["price"] as double) * (item["quantity"] as int)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
        actions: [
          if (cart.isNotEmpty)
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    _showCartBottomSheet();
                  },
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      "${cart.fold(0, (total, item) => total + (item["quantity"] as int))}",
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
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: QTextField(
              label: "Search menu items",
              value: searchQuery,
              hint: "Pasta, Pizza, Dessert...",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),

          // Category Filter
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: QHorizontalScroll(
              children: categories.map((category) {
                bool isSelected = selectedCategory == category["value"];
                return GestureDetector(
                  onTap: () {
                    selectedCategory = category["value"];
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "${category["label"]}",
                        style: TextStyle(
                          color: isSelected ? Colors.white : disabledBoldColor,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Menu Items List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                int cartQuantity = getCartQuantity(item);
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Item Image and Basic Info
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusSm),
                              bottomLeft: Radius.circular(radiusSm),
                            ),
                            child: Image.network(
                              "${item["image"]}",
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          
                          // Info
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${item["name"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      if (item["isVegetarian"] == true)
                                        Container(
                                          margin: EdgeInsets.only(left: spXs),
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: successColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.eco,
                                            size: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      if (item["isSpicy"] == true)
                                        Container(
                                          margin: EdgeInsets.only(left: spXs),
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: dangerColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.local_fire_department,
                                            size: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                    ],
                                  ),
                                  
                                  SizedBox(height: spXs),
                                  
                                  Text(
                                    "${item["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      height: 1.3,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  
                                  SizedBox(height: spXs),
                                  
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 14,
                                        color: warningColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${item["rating"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Icon(
                                        Icons.access_time,
                                        size: 14,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${item["prepTime"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
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
                                  
                                  Row(
                                    children: [
                                      Text(
                                        "\$${(item["price"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                      Spacer(),
                                      if (cartQuantity == 0)
                                        QButton(
                                          label: "Add",
                                          size: bs.sm,
                                          onPressed: () => addToCart(item),
                                        )
                                      else
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () => removeFromCart(item),
                                              child: Container(
                                                padding: EdgeInsets.all(spXs),
                                                decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.remove,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: spSm),
                                            Text(
                                              "$cartQuantity",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                            SizedBox(width: spSm),
                                            GestureDetector(
                                              onTap: () => addToCart(item),
                                              child: Container(
                                                padding: EdgeInsets.all(spXs),
                                                decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  shape: BoxShape.circle,
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
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      // Additional Details (Expandable)
                      ExpansionTile(
                        title: Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if ((item["ingredients"] as List).isNotEmpty) ...[
                                  Text(
                                    "Ingredients:",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    (item["ingredients"] as List).join(", "),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                ],
                                
                                if ((item["allergens"] as List).isNotEmpty) ...[
                                  Text(
                                    "Allergens:",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: dangerColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Wrap(
                                    spacing: spXs,
                                    runSpacing: spXs,
                                    children: (item["allergens"] as List).map((allergen) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: dangerColor.withAlpha(25),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${allergen}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: dangerColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: cart.isNotEmpty 
          ? Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${cart.fold(0, (total, item) => total + (item["quantity"] as int))} items",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${cartTotal.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  QButton(
                    label: "View Cart",
                    size: bs.md,
                    onPressed: () {
                      _showCartBottomSheet();
                    },
                  ),
                ],
              ),
            )
          : null,
    );
  }

  void _showCartBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Your Order",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              Expanded(
                child: ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    final item = cart[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusXs),
                            child: Image.network(
                              "${item["image"]}",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${item["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "\$${(item["price"] as double).toStringAsFixed(2)} each",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  removeFromCart(item);
                                  Navigator.pop(context);
                                  if (cart.isNotEmpty) {
                                    _showCartBottomSheet();
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${item["quantity"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              GestureDetector(
                                onTap: () {
                                  addToCart(item);
                                  Navigator.pop(context);
                                  _showCartBottomSheet();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
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
                        ],
                      ),
                    );
                  },
                ),
              ),
              
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Text(
                      "Total:",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${cartTotal.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Proceed to Checkout",
                  size: bs.md,
                  onPressed: () {
                    Navigator.pop(context);
                    //navigateTo('CheckoutView')
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
