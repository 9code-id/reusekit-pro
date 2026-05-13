import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaPosSystemView extends StatefulWidget {
  const RmaPosSystemView({super.key});

  @override
  State<RmaPosSystemView> createState() => _RmaPosSystemViewState();
}

class _RmaPosSystemViewState extends State<RmaPosSystemView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "";
  double cartTotal = 0.0;
  String paymentMethod = "cash";

  List<Map<String, dynamic>> categories = [
    {"label": "All Items", "value": ""},
    {"label": "RMA Services", "value": "rma_services"},
    {"label": "Repair Parts", "value": "repair_parts"},
    {"label": "Labor", "value": "labor"},
    {"label": "Shipping", "value": "shipping"},
    {"label": "Accessories", "value": "accessories"},
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {"label": "Cash", "value": "cash"},
    {"label": "Credit Card", "value": "credit_card"},
    {"label": "Debit Card", "value": "debit_card"},
    {"label": "Bank Transfer", "value": "bank_transfer"},
    {"label": "Check", "value": "check"},
  ];

  List<Map<String, dynamic>> posItems = [
    {
      "item_id": "POS001",
      "name": "Basic RMA Processing",
      "category": "rma_services",
      "price": 25.0,
      "cost": 15.0,
      "tax_rate": 0.08,
      "sku": "RMA-BASIC-001",
      "description": "Standard RMA processing fee",
      "stock_status": "service",
      "image": "https://picsum.photos/100/100?random=1&keyword=service",
    },
    {
      "item_id": "POS002", 
      "name": "Express RMA Processing",
      "category": "rma_services",
      "price": 50.0,
      "cost": 30.0,
      "tax_rate": 0.08,
      "sku": "RMA-EXPRESS-001",
      "description": "Expedited RMA processing with priority handling",
      "stock_status": "service",
      "image": "https://picsum.photos/100/100?random=2&keyword=express",
    },
    {
      "item_id": "POS003",
      "name": "Replacement Display Screen",
      "category": "repair_parts",
      "price": 120.0,
      "cost": 80.0,
      "tax_rate": 0.08,
      "sku": "PART-SCREEN-001",
      "description": "High-quality replacement display screen",
      "stock_status": "in_stock",
      "stock_quantity": 25,
      "image": "https://picsum.photos/100/100?random=3&keyword=screen",
    },
    {
      "item_id": "POS004",
      "name": "Battery Replacement",
      "category": "repair_parts",
      "price": 45.0,
      "cost": 25.0,
      "tax_rate": 0.08,
      "sku": "PART-BATTERY-001",
      "description": "Original equipment battery replacement",
      "stock_status": "in_stock", 
      "stock_quantity": 50,
      "image": "https://picsum.photos/100/100?random=4&keyword=battery",
    },
    {
      "item_id": "POS005",
      "name": "Technical Diagnostic",
      "category": "labor",
      "price": 75.0,
      "cost": 40.0,
      "tax_rate": 0.08,
      "sku": "LABOR-DIAG-001",
      "description": "Comprehensive technical diagnosis and assessment",
      "stock_status": "service",
      "image": "https://picsum.photos/100/100?random=5&keyword=diagnostic",
    },
    {
      "item_id": "POS006",
      "name": "Standard Shipping",
      "category": "shipping",
      "price": 15.0,
      "cost": 8.0,
      "tax_rate": 0.0,
      "sku": "SHIP-STD-001",
      "description": "Standard shipping service (5-7 business days)",
      "stock_status": "service",
      "image": "https://picsum.photos/100/100?random=6&keyword=shipping",
    },
    {
      "item_id": "POS007",
      "name": "Protective Case",
      "category": "accessories",
      "price": 30.0,
      "cost": 18.0,
      "tax_rate": 0.08,
      "sku": "ACC-CASE-001",
      "description": "Durable protective case for device protection",
      "stock_status": "in_stock",
      "stock_quantity": 35,
      "image": "https://picsum.photos/100/100?random=7&keyword=case",
    },
    {
      "item_id": "POS008",
      "name": "Screen Protector",
      "category": "accessories",
      "price": 12.0,
      "cost": 6.0,
      "tax_rate": 0.08,
      "sku": "ACC-SCREEN-001",
      "description": "Tempered glass screen protector",
      "stock_status": "in_stock",
      "stock_quantity": 100,
      "image": "https://picsum.photos/100/100?random=8&keyword=protector",
    },
  ];

  List<Map<String, dynamic>> cartItems = [];

  List<Map<String, dynamic>> recentSales = [
    {
      "sale_id": "SALE001",
      "date": "2024-03-15",
      "time": "14:30:00",
      "customer": "John Smith",
      "items_count": 3,
      "subtotal": 145.0,
      "tax": 11.60,
      "total": 156.60,
      "payment_method": "credit_card",
      "status": "completed",
    },
    {
      "sale_id": "SALE002",
      "date": "2024-03-15",
      "time": "13:15:00",
      "customer": "Emily Davis",
      "items_count": 2,
      "subtotal": 95.0,
      "tax": 7.60,
      "total": 102.60,
      "payment_method": "cash",
      "status": "completed",
    },
    {
      "sale_id": "SALE003",
      "date": "2024-03-15",
      "time": "11:45:00",
      "customer": "Robert Wilson",
      "items_count": 1,
      "subtotal": 50.0,
      "tax": 4.00,
      "total": 54.00,
      "payment_method": "debit_card",
      "status": "completed",
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    return posItems.where((item) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${item["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${item["sku"]}".toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesCategory = selectedCategory.isEmpty ||
          item["category"] == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  void _addToCart(Map<String, dynamic> item) {
    int existingIndex = cartItems.indexWhere((cartItem) => cartItem["item_id"] == item["item_id"]);
    
    if (existingIndex >= 0) {
      cartItems[existingIndex]["quantity"] = (cartItems[existingIndex]["quantity"] as int) + 1;
    } else {
      cartItems.add({
        ...item,
        "quantity": 1,
      });
    }
    
    _updateCartTotal();
    setState(() {});
    ss("${item["name"]} added to cart");
  }

  void _removeFromCart(int index) {
    cartItems.removeAt(index);
    _updateCartTotal();
    setState(() {});
  }

  void _updateQuantity(int index, int quantity) {
    if (quantity <= 0) {
      _removeFromCart(index);
    } else {
      cartItems[index]["quantity"] = quantity;
      _updateCartTotal();
      setState(() {});
    }
  }

  void _updateCartTotal() {
    double subtotal = 0.0;
    double totalTax = 0.0;
    
    for (var item in cartItems) {
      double itemPrice = item["price"] as double;
      int quantity = item["quantity"] as int;
      double taxRate = item["tax_rate"] as double;
      
      double itemTotal = itemPrice * quantity;
      subtotal += itemTotal;
      totalTax += itemTotal * taxRate;
    }
    
    cartTotal = subtotal + totalTax;
  }

  void _processPayment() async {
    if (cartItems.isEmpty) {
      se("Cart is empty");
      return;
    }

    bool isConfirmed = await confirm("Process payment of \$${cartTotal.currency}?");
    if (!isConfirmed) return;

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();

    cartItems.clear();
    cartTotal = 0.0;
    setState(() {});
    
    ss("Payment processed successfully");
  }

  String _getCategoryLabel(String category) {
    switch (category) {
      case "rma_services":
        return "RMA Services";
      case "repair_parts":
        return "Repair Parts";
      case "labor":
        return "Labor";
      case "shipping":
        return "Shipping";
      case "accessories":
        return "Accessories";
      default:
        return "Unknown";
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "rma_services":
        return primaryColor;
      case "repair_parts":
        return infoColor;
      case "labor":
        return warningColor;
      case "shipping":
        return successColor;
      case "accessories":
        return secondaryColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildItemCard(Map<String, dynamic> item) {
    Color categoryColor = _getCategoryColor("${item["category"]}");
    bool isService = item["stock_status"] == "service";
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Padding(
        padding: EdgeInsets.all(spSm),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(radiusSm),
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
                  
                  SizedBox(height: spXxs),
                  Text(
                    "${item["sku"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: categoryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      _getCategoryLabel("${item["category"]}"),
                      style: TextStyle(
                        fontSize: 10,
                        color: categoryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  
                  if (!isService) ...[
                    SizedBox(height: spXs),
                    Text(
                      "Stock: ${item["stock_quantity"]}",
                      style: TextStyle(
                        fontSize: 12,
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
                  "\$${(item["price"] as double).currency}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                SizedBox(height: spSm),
                QButton(
                  label: "Add to Cart",
                  size: bs.sm,
                  onPressed: () => _addToCart(item),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item, int index) {
    int quantity = item["quantity"] as int;
    double price = item["price"] as double;
    double total = price * quantity;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXxs),
                Text(
                  "\$${price.currency} each",
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
                onTap: () => _updateQuantity(index, quantity - 1),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(Icons.remove, size: 20, color: dangerColor),
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
                onTap: () => _updateQuantity(index, quantity + 1),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(Icons.add, size: 20, color: successColor),
                ),
              ),
            ],
          ),
          
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${total.currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              GestureDetector(
                onTap: () => _removeFromCart(index),
                child: Icon(Icons.delete, color: dangerColor, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSaleItem(Map<String, dynamic> sale) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Sale #${sale["sale_id"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${sale["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spXs),
          Text(
            "${sale["customer"]}",
            style: TextStyle(
              fontSize: 13,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
              SizedBox(width: spXxs),
              Text(
                "${sale["date"]} ${sale["time"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "\$${(sale["total"] as double).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spXs),
          Row(
            children: [
              Text(
                "${sale["items_count"]} items",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "via ${sale["payment_method"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPosTab() {
    return Row(
      children: [
        // Items Panel
        Expanded(
          flex: 2,
          child: Column(
            children: [
              // Search and Filter
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Search items...",
                            value: searchQuery,
                            onChanged: (value) {
                              searchQuery = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.search,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    QDropdownField(
                      label: "Category",
                      items: categories,
                      value: selectedCategory,
                      onChanged: (value, label) {
                        selectedCategory = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Items List
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: filteredItems.map((item) => _buildItemCard(item)).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(width: spMd),
        
        // Cart Panel
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "Shopping Cart",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                SizedBox(height: spMd),
                
                if (cartItems.isEmpty)
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "Cart is empty",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )
                else ...[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: cartItems.asMap().entries.map((entry) => 
                            _buildCartItem(entry.value, entry.key)).toList(),
                      ),
                    ),
                  ),
                  
                  Divider(),
                  
                  Row(
                    children: [
                      Text(
                        "Total:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${cartTotal.currency}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  QDropdownField(
                    label: "Payment Method",
                    items: paymentMethods,
                    value: paymentMethod,
                    onChanged: (value, label) {
                      paymentMethod = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Process Payment",
                      size: bs.md,
                      onPressed: _processPayment,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSalesTab() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: primaryColor.withAlpha(40)),
          ),
          child: Row(
            children: [
              Icon(Icons.receipt_long, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Recent Sales (${recentSales.length})",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        ...recentSales.map((sale) => _buildSaleItem(sale)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "RMA POS System",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Point of Sale", icon: Icon(Icons.point_of_sale)),
        Tab(text: "Sales History", icon: Icon(Icons.receipt_long)),
      ],
      tabChildren: [
        Padding(
          padding: EdgeInsets.all(spMd),
          child: _buildPosTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildSalesTab(),
        ),
      ],
    );
  }
}
