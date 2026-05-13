import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaStoreComparisonView extends StatefulWidget {
  const SpaStoreComparisonView({super.key});

  @override
  State<SpaStoreComparisonView> createState() => _SpaStoreComparisonViewState();
}

class _SpaStoreComparisonViewState extends State<SpaStoreComparisonView> {
  String selectedProduct = "iPhone 15 Pro Max";
  String sortBy = "overall_score";
  
  List<Map<String, dynamic>> products = [
    {"label": "iPhone 15 Pro Max", "value": "iPhone 15 Pro Max"},
    {"label": "Samsung Galaxy S24 Ultra", "value": "Samsung Galaxy S24 Ultra"},
    {"label": "MacBook Pro M3", "value": "MacBook Pro M3"},
    {"label": "Sony WH-1000XM5", "value": "Sony WH-1000XM5"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Overall Score", "value": "overall_score"},
    {"label": "Best Price", "value": "best_price"},
    {"label": "Customer Rating", "value": "customer_rating"},
    {"label": "Shipping Speed", "value": "shipping_speed"},
  ];

  List<Map<String, dynamic>> stores = [
    {
      "name": "Amazon",
      "logo": "https://picsum.photos/40/40?random=1&keyword=amazon",
      "price": 1199.00,
      "originalPrice": 1299.00,
      "discount": 7.7,
      "rating": 4.6,
      "reviews": 12847,
      "shipping": {
        "cost": 0.00,
        "type": "Free",
        "speed": "2-day",
        "prime": true,
      },
      "return_policy": "30 days",
      "warranty": "1 year",
      "stock": "In Stock",
      "features": ["Prime eligible", "Easy returns", "Gift wrapping"],
      "pros": ["Fast shipping", "Great customer service", "Easy returns"],
      "cons": ["Higher prices sometimes", "Packaging waste"],
      "overall_score": 9.2,
    },
    {
      "name": "Best Buy",
      "logo": "https://picsum.photos/40/40?random=2&keyword=bestbuy",
      "price": 1249.00,
      "originalPrice": 1299.00,
      "discount": 3.8,
      "rating": 4.7,
      "reviews": 8934,
      "shipping": {
        "cost": 9.99,
        "type": "Standard",
        "speed": "3-5 days",
        "prime": false,
      },
      "return_policy": "15 days",
      "warranty": "1 year + Extended available",
      "stock": "In Stock",
      "features": ["Geek Squad support", "Store pickup", "Price matching"],
      "pros": ["Expert support", "Physical stores", "Price matching"],
      "cons": ["Shipping costs", "Shorter return window"],
      "overall_score": 8.9,
    },
    {
      "name": "Apple Store",
      "logo": "https://picsum.photos/40/40?random=3&keyword=apple",
      "price": 1299.00,
      "originalPrice": 1299.00,
      "discount": 0.0,
      "rating": 4.9,
      "reviews": 15672,
      "shipping": {
        "cost": 0.00,
        "type": "Free",
        "speed": "1-2 days",
        "prime": false,
      },
      "return_policy": "14 days",
      "warranty": "1 year + AppleCare available",
      "stock": "In Stock",
      "features": ["Official warranty", "Apple Support", "Trade-in program"],
      "pros": ["Official product", "Best support", "Latest stock"],
      "cons": ["Higher prices", "No discounts usually"],
      "overall_score": 9.5,
    },
    {
      "name": "Target",
      "logo": "https://picsum.photos/40/40?random=4&keyword=target",
      "price": 1199.00,
      "originalPrice": 1299.00,
      "discount": 7.7,
      "rating": 4.5,
      "reviews": 6782,
      "shipping": {
        "cost": 5.95,
        "type": "Standard",
        "speed": "3-5 days",
        "prime": false,
      },
      "return_policy": "90 days",
      "warranty": "1 year",
      "stock": "Limited Stock",
      "features": ["RedCard discount", "Store pickup", "90-day returns"],
      "pros": ["Long return period", "RedCard benefits", "Store locations"],
      "cons": ["Limited tech support", "Stock issues"],
      "overall_score": 8.3,
    },
    {
      "name": "Walmart",
      "logo": "https://picsum.photos/40/40?random=5&keyword=walmart",
      "price": 1179.00,
      "originalPrice": 1299.00,
      "discount": 9.2,
      "rating": 4.3,
      "reviews": 4567,
      "shipping": {
        "cost": 0.00,
        "type": "Free",
        "speed": "2-3 days",
        "prime": false,
      },
      "return_policy": "90 days",
      "warranty": "1 year",
      "stock": "In Stock",
      "features": ["Everyday low prices", "Free pickup", "Walmart+"],
      "pros": ["Lowest prices", "Good return policy", "Wide availability"],
      "cons": ["Customer service", "Limited tech support"],
      "overall_score": 8.1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final sortedStores = [...stores];
    
    switch (sortBy) {
      case "best_price":
        sortedStores.sort((a, b) => (a["price"] as double).compareTo(b["price"] as double));
        break;
      case "customer_rating":
        sortedStores.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "shipping_speed":
        sortedStores.sort((a, b) => (a["shipping"]["cost"] as double).compareTo(b["shipping"]["cost"] as double));
        break;
      default:
        sortedStores.sort((a, b) => (b["overall_score"] as double).compareTo(a["overall_score"] as double));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Store Comparison"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product and Sort Selection
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Select Product",
                    items: products,
                    value: selectedProduct,
                    onChanged: (value, label) {
                      selectedProduct = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Sort By",
                    items: sortOptions,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Comparison Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Best Deals for ${selectedProduct}",
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
                    children: [
                      _buildSummaryCard(
                        "Lowest Price",
                        "\$${sortedStores.map((s) => s["price"] as double).reduce((a, b) => a < b ? a : b).currency}",
                        successColor,
                        Icons.trending_down,
                      ),
                      _buildSummaryCard(
                        "Highest Rating",
                        "${sortedStores.map((s) => s["rating"] as double).reduce((a, b) => a > b ? a : b)} ★",
                        warningColor,
                        Icons.star,
                      ),
                      _buildSummaryCard(
                        "Best Overall",
                        "${sortedStores.first["name"]}",
                        primaryColor,
                        Icons.emoji_events,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Store Comparison Cards
            Text(
              "${sortedStores.length} Stores Compared",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: sortedStores.length,
              itemBuilder: (context, index) {
                final store = sortedStores[index];
                final isTopRanked = index == 0;
                return _buildStoreComparisonCard(store, index + 1, isTopRanked);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color, IconData icon) {
    return Container(
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
              Icon(icon, color: color, size: 20),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreComparisonCard(Map<String, dynamic> store, int rank, bool isTopRanked) {
    final shipping = store["shipping"] as Map<String, dynamic>;
    final features = (store["features"] as List).cast<String>();
    final pros = (store["pros"] as List).cast<String>();
    final cons = (store["cons"] as List).cast<String>();

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isTopRanked ? Border.all(color: successColor, width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Store Header
          Row(
            children: [
              // Rank Badge
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: isTopRanked ? successColor : primaryColor,
                  borderRadius: BorderRadius.circular(radiusXl),
                ),
                child: Center(
                  child: Text(
                    "$rank",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              
              // Store Logo and Info
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusXs),
                child: Image.network(
                  "${store["logo"]}",
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${store["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if (isTopRanked) ...[
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "BEST",
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.star, size: 14, color: warningColor),
                        SizedBox(width: 2),
                        Text(
                          "${store["rating"]} (${store["reviews"]} reviews)",
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
              
              // Overall Score
              Column(
                children: [
                  Text(
                    "${store["overall_score"]}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isTopRanked ? successColor : primaryColor,
                    ),
                  ),
                  Text(
                    "Score",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: spSm),

          // Price Information
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "\$${(store["price"] as double).currency}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          if ((store["discount"] as double) > 0) ...[
                            SizedBox(width: spXs),
                            Text(
                              "\$${(store["originalPrice"] as double).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ],
                      ),
                      if ((store["discount"] as double) > 0) ...[
                        SizedBox(height: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "Save ${(store["discount"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
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
                      "Shipping: ${(shipping["cost"] as double) == 0 ? 'Free' : '\$${(shipping["cost"] as double).currency}'}",
                      style: TextStyle(
                        fontSize: 12,
                        color: (shipping["cost"] as double) == 0 ? successColor : disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${shipping["speed"]} delivery",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: spSm),

          // Store Details
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildDetailCard("Stock Status", "${store["stock"]}", 
                  (store["stock"] as String).contains("In Stock") ? successColor : warningColor),
              _buildDetailCard("Return Policy", "${store["return_policy"]}", primaryColor),
              _buildDetailCard("Warranty", "${store["warranty"]}", primaryColor),
            ],
          ),

          SizedBox(height: spSm),

          // Features
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Key Features",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                SizedBox(height: spXs),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: features.map((feature) => Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: infoColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      feature,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),

          SizedBox(height: spSm),

          // Pros and Cons
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle, size: 12, color: successColor),
                          SizedBox(width: spXs),
                          Text(
                            "Pros",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      ...pros.map((pro) => Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Text(
                          "• $pro",
                          style: TextStyle(
                            fontSize: 10,
                            color: successColor,
                          ),
                        ),
                      )).toList(),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.cancel, size: 12, color: dangerColor),
                          SizedBox(width: spXs),
                          Text(
                            "Cons",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      ...cons.map((con) => Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Text(
                          "• $con",
                          style: TextStyle(
                            fontSize: 10,
                            color: dangerColor,
                          ),
                        ),
                      )).toList(),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: spSm),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Visit Store",
                  size: bs.sm,
                  onPressed: () {
                    ss("Redirecting to ${store["name"]}...");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Set Price Alert",
                  size: bs.sm,
                  onPressed: () {
                    ss("Price alert set for ${store["name"]}");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(String title, String value, Color color) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
