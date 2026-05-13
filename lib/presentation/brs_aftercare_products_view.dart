import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsAftercareProductsView extends StatefulWidget {
  const BrsAftercareProductsView({super.key});

  @override
  State<BrsAftercareProductsView> createState() => _BrsAftercareProductsViewState();
}

class _BrsAftercareProductsViewState extends State<BrsAftercareProductsView> {
  String selectedCategory = "All";
  String searchQuery = "";
  List<Map<String, dynamic>> cartItems = [];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Hair Care", "value": "Hair Care"},
    {"label": "Beard Care", "value": "Beard Care"},
    {"label": "Skin Care", "value": "Skin Care"},
    {"label": "Styling", "value": "Styling"},
    {"label": "Tools", "value": "Tools"},
  ];

  List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "Premium Hair Pomade",
      "category": "Hair Care",
      "price": 25.99,
      "originalPrice": 32.99,
      "brand": "BarberPro",
      "rating": 4.8,
      "reviews": 156,
      "image": "https://picsum.photos/200/200?random=1&keyword=pomade",
      "description": "Professional grade pomade for strong hold and shine",
      "ingredients": "Natural wax, essential oils, vitamin E",
      "usage": "Apply to damp hair for best results",
      "inStock": true,
      "bestseller": true,
    },
    {
      "id": 2,
      "name": "Beard Growth Oil",
      "category": "Beard Care",
      "price": 18.99,
      "originalPrice": 22.99,
      "brand": "BeardMaster",
      "rating": 4.6,
      "reviews": 89,
      "image": "https://picsum.photos/200/200?random=2&keyword=beard+oil",
      "description": "Nourishing oil blend for healthy beard growth",
      "ingredients": "Argan oil, jojoba oil, vitamin B complex",
      "usage": "Massage into beard and skin daily",
      "inStock": true,
      "bestseller": false,
    },
    {
      "id": 3,
      "name": "Matte Clay Styling",
      "category": "Styling",
      "price": 22.50,
      "originalPrice": 28.00,
      "brand": "StyleCraft",
      "rating": 4.7,
      "reviews": 203,
      "image": "https://picsum.photos/200/200?random=3&keyword=hair+clay",
      "description": "Professional matte clay for textured styling",
      "ingredients": "Bentonite clay, natural minerals",
      "usage": "Work through dry hair for texture",
      "inStock": true,
      "bestseller": true,
    },
    {
      "id": 4,
      "name": "Face Moisturizer",
      "category": "Skin Care",
      "price": 16.99,
      "originalPrice": 19.99,
      "brand": "SkinGuard",
      "rating": 4.5,
      "reviews": 67,
      "image": "https://picsum.photos/200/200?random=4&keyword=moisturizer",
      "description": "Daily moisturizer for all skin types",
      "ingredients": "Hyaluronic acid, aloe vera, SPF 15",
      "usage": "Apply morning and evening",
      "inStock": false,
      "bestseller": false,
    },
    {
      "id": 5,
      "name": "Professional Trimmer",
      "category": "Tools",
      "price": 89.99,
      "originalPrice": 109.99,
      "brand": "TrimTech",
      "rating": 4.9,
      "reviews": 134,
      "image": "https://picsum.photos/200/200?random=5&keyword=trimmer",
      "description": "Cordless precision trimmer with ceramic blades",
      "ingredients": "Titanium-coated ceramic blades",
      "usage": "Use on dry hair for precision trimming",
      "inStock": true,
      "bestseller": true,
    },
    {
      "id": 6,
      "name": "Hair Serum",
      "category": "Hair Care",
      "price": 14.99,
      "originalPrice": 17.99,
      "brand": "HairVital",
      "rating": 4.4,
      "reviews": 78,
      "image": "https://picsum.photos/200/200?random=6&keyword=hair+serum",
      "description": "Nourishing serum for damaged hair repair",
      "ingredients": "Keratin, biotin, natural proteins",
      "usage": "Apply to towel-dried hair",
      "inStock": true,
      "bestseller": false,
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    return products.where((product) {
      bool matchesCategory = selectedCategory == "All" || product["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty || 
        product["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        product["brand"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void addToCart(Map<String, dynamic> product) {
    int existingIndex = cartItems.indexWhere((item) => item["id"] == product["id"]);
    
    if (existingIndex >= 0) {
      cartItems[existingIndex]["quantity"] = (cartItems[existingIndex]["quantity"] as int) + 1;
    } else {
      cartItems.add({
        ...product,
        "quantity": 1,
      });
    }
    
    setState(() {});
    ss("${product["name"]} added to cart");
  }

  double get cartTotal {
    return cartItems.fold(0.0, (sum, item) => 
      sum + ((item["price"] as double) * (item["quantity"] as int)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aftercare Products"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () => _showCartBottomSheet(),
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      "${cartItems.length}",
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
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Professional Aftercare",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Maintain your fresh look with premium products",
                    style: TextStyle(
                      color: Colors.white.withAlpha(230),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.local_shipping, color: Colors.white, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Free delivery on orders over \$50",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search products...",
                    value: searchQuery,
                    hint: "Product name or brand",
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
            
            SizedBox(height: spMd),
            
            // Category Filter
            QCategoryPicker(
              label: "Categories",
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Results Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredProducts.length} Products Found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: warningColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Bestsellers",
                      style: TextStyle(
                        color: warningColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Products Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredProducts.map((product) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                            child: Image.network(
                              "${product["image"]}",
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (product["bestseller"] as bool)
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "Bestseller",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          if (!(product["inStock"] as bool))
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "Out of Stock",
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
                      
                      // Product Details
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${product["brand"]}",
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${product["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${product["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spSm),
                            
                            // Rating
                            Row(
                              children: [
                                Icon(Icons.star, color: warningColor, size: 14),
                                SizedBox(width: spXs),
                                Text(
                                  "${product["rating"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  " (${product["reviews"]})",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Price
                            Row(
                              children: [
                                Text(
                                  "\$${(product["price"] as double).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "\$${(product["originalPrice"] as double).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Add to Cart Button
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: (product["inStock"] as bool) ? "Add to Cart" : "Out of Stock",
                                size: bs.sm,
                                onPressed: (product["inStock"] as bool) ? () => addToCart(product) : null,
                              ),
                            ),
                          ],
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
    );
  }

  void _showCartBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Shopping Cart",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => back(),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            if (cartItems.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 64,
                        color: disabledBoldColor,
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "Your cart is empty",
                        style: TextStyle(
                          fontSize: fsH6,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
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
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "${item["brand"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "\$${(item["price"] as double).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if ((item["quantity"] as int) > 1) {
                                    item["quantity"] = (item["quantity"] as int) - 1;
                                  } else {
                                    cartItems.removeAt(index);
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: dangerColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: spSm),
                                child: Text(
                                  "${item["quantity"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  item["quantity"] = (item["quantity"] as int) + 1;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 16,
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
            
            if (cartItems.isNotEmpty) ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total:",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$${cartTotal.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Continue Shopping",
                      size: bs.md,
                      onPressed: () => back(),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Checkout",
                      size: bs.md,
                      onPressed: () {
                        back();
                        ss("Proceeding to checkout...");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
