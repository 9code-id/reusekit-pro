import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPromo9View extends StatefulWidget {
  @override
  State<GrlPromo9View> createState() => _GrlPromo9ViewState();
}

class _GrlPromo9ViewState extends State<GrlPromo9View> {
  bool loading = false;
  String selectedFilter = "All";
  String searchQuery = "";
  List<String> favoriteOffers = [];
  String selectedCategory = "Flash Sale";
  
  List<Map<String, dynamic>> flashSaleData = [
    {
      "id": 1,
      "title": "iPhone 14 Pro Max",
      "originalPrice": 1299.0,
      "salePrice": 999.0,
      "discount": 23,
      "image": "https://picsum.photos/200/200?random=1&keyword=phone",
      "timeLeft": "02:45:30",
      "soldCount": 45,
      "totalStock": 100,
      "rating": 4.8,
      "reviews": 234,
      "store": "TechWorld",
      "category": "Electronics"
    },
    {
      "id": 2,
      "title": "Nike Air Max 270",
      "originalPrice": 150.0,
      "salePrice": 89.0,
      "discount": 41,
      "image": "https://picsum.photos/200/200?random=2&keyword=shoes",
      "timeLeft": "01:12:45",
      "soldCount": 78,
      "totalStock": 120,
      "rating": 4.6,
      "reviews": 156,
      "store": "SportZone",
      "category": "Fashion"
    },
    {
      "id": 3,
      "title": "Samsung 55\" 4K TV",
      "originalPrice": 899.0,
      "salePrice": 649.0,
      "discount": 28,
      "image": "https://picsum.photos/200/200?random=3&keyword=tv",
      "timeLeft": "04:30:15",
      "soldCount": 23,
      "totalStock": 50,
      "rating": 4.7,
      "reviews": 89,
      "store": "ElectroMart",
      "category": "Electronics"
    },
    {
      "id": 4,
      "title": "MacBook Air M2",
      "originalPrice": 1199.0,
      "salePrice": 999.0,
      "discount": 17,
      "image": "https://picsum.photos/200/200?random=4&keyword=laptop",
      "timeLeft": "06:15:20",
      "soldCount": 12,
      "totalStock": 30,
      "rating": 4.9,
      "reviews": 167,
      "store": "AppleStore",
      "category": "Electronics"
    },
    {
      "id": 5,
      "title": "Adidas Ultraboost 22",
      "originalPrice": 180.0,
      "salePrice": 129.0,
      "discount": 28,
      "image": "https://picsum.photos/200/200?random=5&keyword=sneakers",
      "timeLeft": "03:45:10",
      "soldCount": 56,
      "totalStock": 80,
      "rating": 4.5,
      "reviews": 203,
      "store": "FootLocker",
      "category": "Fashion"
    }
  ];

  List<Map<String, dynamic>> megaSaleData = [
    {
      "id": 6,
      "title": "Sony WH-1000XM5",
      "originalPrice": 399.0,
      "salePrice": 299.0,
      "discount": 25,
      "image": "https://picsum.photos/200/200?random=6&keyword=headphones",
      "endDate": "Dec 31, 2024",
      "rating": 4.8,
      "reviews": 445,
      "store": "AudioHub",
      "category": "Electronics",
      "features": ["Noise Canceling", "30h Battery", "Wireless"]
    },
    {
      "id": 7,
      "title": "Levi's 501 Jeans",
      "originalPrice": 89.0,
      "salePrice": 59.0,
      "discount": 34,
      "image": "https://picsum.photos/200/200?random=7&keyword=jeans",
      "endDate": "Dec 25, 2024",
      "rating": 4.4,
      "reviews": 567,
      "store": "Levi's",
      "category": "Fashion",
      "features": ["Classic Fit", "100% Cotton", "Original"]
    },
    {
      "id": 8,
      "title": "KitchenAid Mixer",
      "originalPrice": 379.0,
      "salePrice": 279.0,
      "discount": 26,
      "image": "https://picsum.photos/200/200?random=8&keyword=mixer",
      "endDate": "Jan 15, 2025",
      "rating": 4.7,
      "reviews": 234,
      "store": "KitchenPro",
      "category": "Home",
      "features": ["5 Qt Bowl", "10 Speeds", "Attachments"]
    }
  ];

  List<Map<String, dynamic>> clearanceData = [
    {
      "id": 9,
      "title": "Winter Coat Collection",
      "originalPrice": 199.0,
      "salePrice": 79.0,
      "discount": 60,
      "image": "https://picsum.photos/200/200?random=9&keyword=coat",
      "stock": "Limited",
      "rating": 4.3,
      "reviews": 123,
      "store": "WinterWear",
      "category": "Fashion",
      "reason": "End of Season"
    },
    {
      "id": 10,
      "title": "Fitness Equipment Set",
      "originalPrice": 299.0,
      "salePrice": 149.0,
      "discount": 50,
      "image": "https://picsum.photos/200/200?random=10&keyword=fitness",
      "stock": "Final Sale",
      "rating": 4.2,
      "reviews": 89,
      "store": "FitGear",
      "category": "Sports",
      "reason": "Overstock"
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "Flash Sale", "value": "Flash Sale", "count": 25},
    {"label": "Mega Sale", "value": "Mega Sale", "count": 15},
    {"label": "Clearance", "value": "Clearance", "count": 8},
  ];

  List<Map<String, dynamic>> get currentData {
    switch (selectedCategory) {
      case "Flash Sale":
        return flashSaleData;
      case "Mega Sale":
        return megaSaleData;
      case "Clearance":
        return clearanceData;
      default:
        return [];
    }
  }

  void _toggleFavorite(int offerId) {
    if (favoriteOffers.contains(offerId.toString())) {
      favoriteOffers.remove(offerId.toString());
      ss("Removed from favorites");
    } else {
      favoriteOffers.add(offerId.toString());
      ss("Added to favorites");
    }
    setState(() {});
  }

  void _addToCart(Map<String, dynamic> item) {
    ss("${item["title"]} added to cart");
  }

  void _shareOffer(Map<String, dynamic> item) {
    ss("Sharing ${item["title"]}");
  }

  Widget _buildFlashSaleCard(Map<String, dynamic> item) {
    bool isFavorite = favoriteOffers.contains(item["id"].toString());
    double progress = (item["soldCount"] as int) / (item["totalStock"] as int);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and badges
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                child: Image.network(
                  "${item["image"]}",
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spXs,
                left: spXs,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "-${item["discount"]}%",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: spXs,
                right: spXs,
                child: GestureDetector(
                  onTap: () => _toggleFavorite(item["id"] as int),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(200),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? dangerColor : disabledBoldColor,
                      size: 18,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: spXs,
                left: spXs,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${item["timeLeft"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and rating
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${item["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: warningColor, size: 12),
                          SizedBox(width: 2),
                          Text(
                            "${item["rating"]}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                // Store name
                Text(
                  "${item["store"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                
                // Prices
                Row(
                  children: [
                    Text(
                      "\$${(item["salePrice"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "\$${(item["originalPrice"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                // Progress bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sold: ${item["soldCount"]}/${item["totalStock"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${(progress * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Add to Cart",
                        size: bs.sm,
                        onPressed: () => _addToCart(item),
                      ),
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.share,
                      size: bs.sm,
                      onPressed: () => _shareOffer(item),
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

  Widget _buildMegaSaleCard(Map<String, dynamic> item) {
    bool isFavorite = favoriteOffers.contains(item["id"].toString());
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(radiusLg)),
            child: Image.network(
              "${item["image"]}",
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          
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
                          "${item["title"]}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _toggleFavorite(item["id"] as int),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? dangerColor : disabledBoldColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  
                  Text(
                    "${item["store"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "-${item["discount"]}%",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: warningColor, size: 10),
                            SizedBox(width: 2),
                            Text(
                              "${item["rating"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  
                  Row(
                    children: [
                      Text(
                        "\$${(item["salePrice"] as double).toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "\$${(item["originalPrice"] as double).toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  
                  Text(
                    "Ends: ${item["endDate"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClearanceCard(Map<String, dynamic> item) {
    bool isFavorite = favoriteOffers.contains(item["id"].toString());
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(color: warningColor.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                child: Image.network(
                  "${item["image"]}",
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spXs,
                left: spXs,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: warningColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "CLEARANCE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: spXs,
                right: spXs,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "-${item["discount"]}%",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${item["title"]}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _toggleFavorite(item["id"] as int),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? dangerColor : disabledBoldColor,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Text(
                  "${item["store"]} • ${item["reason"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                
                Row(
                  children: [
                    Text(
                      "\$${(item["salePrice"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "\$${(item["originalPrice"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${item["stock"]}",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Buy Now",
                    size: bs.sm,
                    onPressed: () => _addToCart(item),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Special Sales"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () {},
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header stats
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor, primaryColor.withAlpha(200)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Icon(Icons.flash_on, color: Colors.white, size: 24),
                              SizedBox(height: 4),
                              Text(
                                "Flash Sales",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "25 Items",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(width: 1, height: 40, color: Colors.white.withAlpha(100)),
                        Expanded(
                          child: Column(
                            children: [
                              Icon(Icons.local_fire_department, color: Colors.white, size: 24),
                              SizedBox(height: 4),
                              Text(
                                "Mega Sales",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "15 Items",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(width: 1, height: 40, color: Colors.white.withAlpha(100)),
                        Expanded(
                          child: Column(
                            children: [
                              Icon(Icons.inventory_2, color: Colors.white, size: 24),
                              SizedBox(height: 4),
                              Text(
                                "Clearance",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "8 Items",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  // Category picker
                  QCategoryPicker(
                    items: categories,
                    value: selectedCategory,
                    onChanged: (index, label, value, item) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),
                  
                  // Content based on selected category
                  if (selectedCategory == "Flash Sale") ...[
                    Text(
                      "⚡ Flash Sale Deals",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Limited time offers with countdown timers",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: spMd),
                    ...flashSaleData.map((item) => _buildFlashSaleCard(item)),
                  ],
                  
                  if (selectedCategory == "Mega Sale") ...[
                    Text(
                      "🔥 Mega Sale Offers",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Extended sale period with great discounts",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: spMd),
                    ...megaSaleData.map((item) => _buildMegaSaleCard(item)),
                  ],
                  
                  if (selectedCategory == "Clearance") ...[
                    Text(
                      "📦 Clearance Items",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Final sale items with maximum discounts",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: spMd),
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: clearanceData.map((item) {
                        return _buildClearanceCard(item);
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}
