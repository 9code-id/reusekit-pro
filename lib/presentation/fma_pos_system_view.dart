import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaPosSystemView extends StatefulWidget {
  const FmaPosSystemView({super.key});

  @override
  State<FmaPosSystemView> createState() => _FmaPosSystemViewState();
}

class _FmaPosSystemViewState extends State<FmaPosSystemView> {
  String searchQuery = "";
  String selectedCategory = "all";
  int selectedTable = 0;
  List<Map<String, dynamic>> cartItems = [];
  double totalAmount = 0.0;
  double taxAmount = 0.0;
  double discountAmount = 0.0;
  bool isProcessingPayment = false;

  List<Map<String, dynamic>> categories = [
    {
      "label": "All Items",
      "value": "all",
    },
    {
      "label": "Appetizers",
      "value": "appetizers",
    },
    {
      "label": "Main Course",
      "value": "main",
    },
    {
      "label": "Beverages",
      "value": "beverages",
    },
    {
      "label": "Desserts",
      "value": "desserts",
    },
    {
      "label": "Specials",
      "value": "specials",
    },
  ];

  List<Map<String, dynamic>> menuItems = [
    {
      "id": "1",
      "name": "Caesar Salad",
      "category": "appetizers",
      "price": 12.99,
      "image": "https://picsum.photos/200/150?random=1&keyword=salad",
      "description": "Fresh romaine lettuce with caesar dressing",
      "inStock": true,
      "prepTime": "5 min",
    },
    {
      "id": "2",
      "name": "Grilled Chicken Breast",
      "category": "main",
      "price": 24.99,
      "image": "https://picsum.photos/200/150?random=2&keyword=chicken",
      "description": "Tender grilled chicken with herbs and spices",
      "inStock": true,
      "prepTime": "15 min",
    },
    {
      "id": "3",
      "name": "Coca Cola",
      "category": "beverages",
      "price": 3.99,
      "image": "https://picsum.photos/200/150?random=3&keyword=cola",
      "description": "Ice cold refreshing cola drink",
      "inStock": true,
      "prepTime": "1 min",
    },
    {
      "id": "4",
      "name": "Chocolate Cake",
      "category": "desserts",
      "price": 8.99,
      "image": "https://picsum.photos/200/150?random=4&keyword=cake",
      "description": "Rich chocolate cake with chocolate frosting",
      "inStock": true,
      "prepTime": "3 min",
    },
    {
      "id": "5",
      "name": "Beef Burger",
      "category": "main",
      "price": 18.99,
      "image": "https://picsum.photos/200/150?random=5&keyword=burger",
      "description": "Juicy beef patty with fresh vegetables",
      "inStock": true,
      "prepTime": "12 min",
    },
    {
      "id": "6",
      "name": "Fresh Orange Juice",
      "category": "beverages",
      "price": 5.99,
      "image": "https://picsum.photos/200/150?random=6&keyword=orange",
      "description": "Freshly squeezed orange juice",
      "inStock": false,
      "prepTime": "2 min",
    },
    {
      "id": "7",
      "name": "Chef's Special Pasta",
      "category": "specials",
      "price": 22.99,
      "image": "https://picsum.photos/200/150?random=7&keyword=pasta",
      "description": "Today's special pasta with seasonal ingredients",
      "inStock": true,
      "prepTime": "18 min",
    },
    {
      "id": "8",
      "name": "Garlic Bread",
      "category": "appetizers",
      "price": 6.99,
      "image": "https://picsum.photos/200/150?random=8&keyword=bread",
      "description": "Crispy garlic bread with herbs",
      "inStock": true,
      "prepTime": "5 min",
    },
  ];

  List<Map<String, dynamic>> tables = [
    {"number": 1, "status": "available", "capacity": 4},
    {"number": 2, "status": "occupied", "capacity": 6},
    {"number": 3, "status": "available", "capacity": 2},
    {"number": 4, "status": "reserved", "capacity": 8},
    {"number": 5, "status": "available", "capacity": 4},
    {"number": 6, "status": "occupied", "capacity": 6},
  ];

  List<Map<String, dynamic>> get filteredMenuItems {
    return menuItems.where((item) {
      bool matchesSearch = "${item["name"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "all" || item["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _calculateTotal();
  }

  void _calculateTotal() {
    double subtotal = cartItems.fold(0.0, (sum, item) => 
        sum + ((item["price"] as double) * (item["quantity"] as int)));
    taxAmount = subtotal * 0.08; // 8% tax
    totalAmount = subtotal + taxAmount - discountAmount;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("POS System"),
        actions: [
          IconButton(
            icon: Icon(Icons.table_restaurant),
            onPressed: () => _showTableSelection(),
          ),
          IconButton(
            icon: Icon(Icons.receipt_long),
            onPressed: () => _viewOrderHistory(),
          ),
        ],
      ),
      body: Row(
        children: [
          // Menu Items Section (Left)
          Expanded(
            flex: 2,
            child: _buildMenuSection(),
          ),
          
          // Order Cart Section (Right)
          Container(
            width: 400,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(
                left: BorderSide(color: disabledOutlineBorderColor),
              ),
            ),
            child: _buildCartSection(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchAndFilter(),
          SizedBox(height: spLg),
          _buildMenuGrid(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Expanded(
                child: QTextField(
                  label: "Search menu items...",
                  value: searchQuery,
                  hint: "Enter item name",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.table_restaurant,
                      color: primaryColor,
                      size: 20,
                    ),
                    Text(
                      selectedTable == 0 ? "No Table" : "Table $selectedTable",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          QCategoryPicker(
            items: categories,
            value: selectedCategory,
            onChanged: (index, label, value, item) {
              selectedCategory = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuGrid() {
    List<Map<String, dynamic>> items = filteredMenuItems;
    
    return ResponsiveGridView(
      minItemWidth: 200,
      children: items.map((item) => _buildMenuItemCard(item)).toList(),
    );
  }

  Widget _buildMenuItemCard(Map<String, dynamic> item) {
    bool inStock = item["inStock"] as bool;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item Image
          Stack(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusMd),
                    topRight: Radius.circular(radiusMd),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusMd),
                    topRight: Radius.circular(radiusMd),
                  ),
                  child: Image.network(
                    "${item["image"]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (!inStock)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(128),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusMd),
                        topRight: Radius.circular(radiusMd),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "OUT OF STOCK",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${item["prepTime"]}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Item Details
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${item["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spMd),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${(item["price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    QButton(
                      label: "Add",
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: inStock ? () => _addToCart(item) : null,
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

  Widget _buildCartSection() {
    return Column(
      children: [
        // Cart Header
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusMd),
              topRight: Radius.circular(radiusMd),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              SizedBox(width: spSm),
              Text(
                "Current Order",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Text(
                "${cartItems.length} items",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        
        // Cart Items List
        Expanded(
          child: cartItems.isEmpty
              ? _buildEmptyCart()
              : ListView.builder(
                  padding: EdgeInsets.all(spMd),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return _buildCartItem(cartItems[index], index);
                  },
                ),
        ),
        
        // Cart Summary and Actions
        if (cartItems.isNotEmpty) _buildCartSummary(),
      ],
    );
  }

  Widget _buildEmptyCart() {
    return Container(
      padding: EdgeInsets.all(spXl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 64,
            color: disabledColor,
          ),
          SizedBox(height: spMd),
          Text(
            "Cart is Empty",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Add items from the menu to start an order",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusSm),
              child: Image.network(
                "${item["image"]}",
                fit: BoxFit.cover,
              ),
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
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "\$${(item["price"] as double).toStringAsFixed(2)}",
                  style: TextStyle(
                    color: successColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => _decreaseQuantity(index),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.remove,
                    size: 16,
                    color: dangerColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${item["quantity"]}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: spSm),
              GestureDetector(
                onTap: () => _increaseQuantity(index),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.add,
                    size: 16,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCartSummary() {
    double subtotal = cartItems.fold(0.0, (sum, item) => 
        sum + ((item["price"] as double) * (item["quantity"] as int)));
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: disabledOutlineBorderColor),
        ),
      ),
      child: Column(
        children: [
          // Discount Section
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Discount Code",
                  value: "",
                  hint: "Enter discount code",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Apply",
                size: bs.sm,
                onPressed: () => _applyDiscount(),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // Summary Rows
          _buildSummaryRow("Subtotal", subtotal),
          _buildSummaryRow("Tax (8%)", taxAmount),
          if (discountAmount > 0)
            _buildSummaryRow("Discount", -discountAmount, color: successColor),
          Divider(),
          _buildSummaryRow("Total", totalAmount, isTotal: true),
          
          SizedBox(height: spMd),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Clear Cart",
                  size: bs.sm,
                  onPressed: () => _clearCart(),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                flex: 2,
                child: QButton(
                  label: isProcessingPayment ? "Processing..." : "Process Payment",
                  size: bs.sm,
                  onPressed: isProcessingPayment ? null : () => _processPayment(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {Color? color, bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: color ?? (isTotal ? primaryColor : disabledBoldColor),
            ),
          ),
          Text(
            "\$${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: color ?? (isTotal ? primaryColor : disabledBoldColor),
            ),
          ),
        ],
      ),
    );
  }

  void _addToCart(Map<String, dynamic> item) {
    int existingIndex = cartItems.indexWhere((cartItem) => cartItem["id"] == item["id"]);
    
    if (existingIndex >= 0) {
      cartItems[existingIndex]["quantity"] = (cartItems[existingIndex]["quantity"] as int) + 1;
    } else {
      cartItems.add({
        ...item,
        "quantity": 1,
      });
    }
    
    _calculateTotal();
    ss("${item["name"]} added to cart");
  }

  void _increaseQuantity(int index) {
    cartItems[index]["quantity"] = (cartItems[index]["quantity"] as int) + 1;
    _calculateTotal();
  }

  void _decreaseQuantity(int index) {
    int currentQuantity = cartItems[index]["quantity"] as int;
    if (currentQuantity > 1) {
      cartItems[index]["quantity"] = currentQuantity - 1;
    } else {
      cartItems.removeAt(index);
    }
    _calculateTotal();
  }

  void _clearCart() async {
    bool isConfirmed = await confirm("Are you sure you want to clear the cart?");
    if (isConfirmed) {
      cartItems.clear();
      _calculateTotal();
      ss("Cart cleared");
    }
  }

  void _applyDiscount() {
    // Apply discount logic
    discountAmount = 5.0; // Example discount
    _calculateTotal();
    ss("Discount applied");
  }

  void _processPayment() async {
    if (cartItems.isEmpty) {
      se("Cart is empty");
      return;
    }
    
    isProcessingPayment = true;
    setState(() {});
    
    // Simulate payment processing
    await Future.delayed(Duration(seconds: 2));
    
    isProcessingPayment = false;
    cartItems.clear();
    discountAmount = 0.0;
    _calculateTotal();
    
    ss("Payment processed successfully");
  }

  void _showTableSelection() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Select Table"),
        content: Container(
          width: double.maxFinite,
          child: ResponsiveGridView(
            minItemWidth: 100,
            children: tables.map((table) => _buildTableOption(table)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildTableOption(Map<String, dynamic> table) {
    String status = table["status"];
    Color statusColor = status == "available" ? successColor : 
                       status == "occupied" ? dangerColor : warningColor;
    
    return GestureDetector(
      onTap: status == "available" ? () {
        selectedTable = table["number"] as int;
        Navigator.pop(context);
        setState(() {});
      } : null,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: statusColor.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: statusColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.table_restaurant,
              color: statusColor,
              size: 30,
            ),
            Text(
              "Table ${table["number"]}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),
            Text(
              "${table["capacity"]} seats",
              style: TextStyle(
                fontSize: 12,
                color: statusColor,
              ),
            ),
            Text(
              status.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _viewOrderHistory() {
    // Navigate to order history view
    ss("Opening order history");
  }
}
