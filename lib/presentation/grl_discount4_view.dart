import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDiscount4View extends StatefulWidget {
  @override
  State<GrlDiscount4View> createState() => _GrlDiscount4ViewState();
}

class _GrlDiscount4ViewState extends State<GrlDiscount4View> {
  String selectedSortBy = "Discount";
  String selectedFilter = "All";
  bool showOnlyFavorites = false;
  
  List<Map<String, dynamic>> sortOptions = [
    {"label": "Discount", "value": "Discount"},
    {"label": "Expiry Date", "value": "Expiry Date"},
    {"label": "Popularity", "value": "Popularity"},
    {"label": "Price", "value": "Price"},
  ];
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Limited Time", "value": "Limited Time"},
    {"label": "Flash Sale", "value": "Flash Sale"},
    {"label": "Seasonal", "value": "Seasonal"},
    {"label": "Member Only", "value": "Member Only"},
  ];

  List<Map<String, dynamic>> offers = [
    {
      "id": 1,
      "title": "Mega Electronics Sale",
      "subtitle": "Up to 70% Off on Gadgets",
      "description": "Biggest electronics sale of the year with massive discounts on smartphones, laptops, and accessories",
      "discount": 70,
      "originalPrice": 899.99,
      "salePrice": 269.99,
      "type": "Flash Sale",
      "category": "Electronics",
      "brand": "TechMart",
      "image": "https://picsum.photos/400/300?random=1&keyword=electronics",
      "rating": 4.8,
      "reviews": 2450,
      "expiryDate": "2024-07-28",
      "timeLeft": "2 days",
      "stock": 45,
      "sold": 1230,
      "tags": ["Best Seller", "Limited Stock"],
      "isFavorite": true,
      "isNew": false,
      "features": ["Free Shipping", "1 Year Warranty", "Easy Returns"],
    },
    {
      "id": 2,
      "title": "Summer Fashion Fiesta",
      "subtitle": "Trendy Outfits for Everyone",
      "description": "Refresh your wardrobe with the latest summer collection featuring vibrant colors and comfortable fabrics",
      "discount": 55,
      "originalPrice": 199.99,
      "salePrice": 89.99,
      "type": "Seasonal",
      "category": "Fashion",
      "brand": "StyleHub",
      "image": "https://picsum.photos/400/300?random=2&keyword=fashion",
      "rating": 4.6,
      "reviews": 1850,
      "expiryDate": "2024-08-15",
      "timeLeft": "18 days",
      "stock": 120,
      "sold": 890,
      "tags": ["Trending", "Summer Special"],
      "isFavorite": false,
      "isNew": true,
      "features": ["Free Delivery", "Size Exchange", "Premium Quality"],
    },
    {
      "id": 3,
      "title": "Home & Kitchen Bonanza",
      "subtitle": "Transform Your Living Space",
      "description": "Complete home makeover with premium kitchen appliances and stylish home decor items at unbeatable prices",
      "discount": 40,
      "originalPrice": 459.99,
      "salePrice": 275.99,
      "type": "Limited Time",
      "category": "Home",
      "brand": "HomeEssentials",
      "image": "https://picsum.photos/400/300?random=3&keyword=kitchen",
      "rating": 4.7,
      "reviews": 950,
      "expiryDate": "2024-08-05",
      "timeLeft": "8 days",
      "stock": 75,
      "sold": 445,
      "tags": ["Premium Quality", "Home Essentials"],
      "isFavorite": true,
      "isNew": false,
      "features": ["Installation Service", "2 Year Warranty", "24/7 Support"],
    },
    {
      "id": 4,
      "title": "Beauty & Wellness Week",
      "subtitle": "Glow Up Your Routine",
      "description": "Exclusive beauty deals featuring top-rated skincare, makeup, and wellness products from premium brands",
      "discount": 45,
      "originalPrice": 149.99,
      "salePrice": 82.49,
      "type": "Member Only",
      "category": "Beauty",
      "brand": "GlowUp",
      "image": "https://picsum.photos/400/300?random=4&keyword=beauty",
      "rating": 4.9,
      "reviews": 3200,
      "expiryDate": "2024-07-30",
      "timeLeft": "3 days",
      "stock": 200,
      "sold": 1680,
      "tags": ["Members Only", "Premium Brands"],
      "isFavorite": false,
      "isNew": true,
      "features": ["Free Samples", "Beauty Consultation", "Express Delivery"],
    },
    {
      "id": 5,
      "title": "Sports & Fitness Fest",
      "subtitle": "Gear Up for Action",
      "description": "Complete fitness transformation with professional sports equipment and activewear from top athletic brands",
      "discount": 35,
      "originalPrice": 299.99,
      "salePrice": 194.99,
      "type": "Flash Sale",
      "category": "Sports",
      "brand": "FitZone",
      "image": "https://picsum.photos/400/300?random=5&keyword=sports",
      "rating": 4.5,
      "reviews": 1200,
      "expiryDate": "2024-08-12",
      "timeLeft": "15 days",
      "stock": 90,
      "sold": 567,
      "tags": ["Athletic Gear", "Performance"],
      "isFavorite": true,
      "isNew": false,
      "features": ["Fitness Tracking", "Professional Grade", "Flexible Returns"],
    },
  ];

  List<Map<String, dynamic>> get filteredOffers {
    List<Map<String, dynamic>> filtered = offers.where((offer) {
      bool matchesFilter = selectedFilter == "All" || offer["type"] == selectedFilter;
      bool matchesFavorites = !showOnlyFavorites || offer["isFavorite"] == true;
      return matchesFilter && matchesFavorites;
    }).toList();
    
    // Sort the filtered offers
    filtered.sort((a, b) {
      switch (selectedSortBy) {
        case "Discount":
          return (b["discount"] as int).compareTo(a["discount"] as int);
        case "Price":
          return (a["salePrice"] as double).compareTo(b["salePrice"] as double);
        case "Popularity":
          return (b["reviews"] as int).compareTo(a["reviews"] as int);
        case "Expiry Date":
          return a["expiryDate"].toString().compareTo(b["expiryDate"].toString());
        default:
          return 0;
      }
    });
    
    return filtered;
  }

  void _toggleFavorite(int id) {
    int index = offers.indexWhere((offer) => offer["id"] == id);
    if (index != -1) {
      offers[index]["isFavorite"] = !(offers[index]["isFavorite"] as bool);
      setState(() {});
    }
  }

  Widget _buildOfferCard(Map<String, dynamic> offer) {
    double savingAmount = (offer["originalPrice"] as double) - (offer["salePrice"] as double);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and Badge Section
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                child: Image.network(
                  "${offer["image"]}",
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              
              // Discount Badge
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${offer["discount"]}% OFF",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              // New Badge
              if (offer["isNew"] == true)
                Positioned(
                  top: spSm,
                  right: 60,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "NEW",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              
              // Favorite Button
              Positioned(
                top: spSm,
                right: spSm,
                child: GestureDetector(
                  onTap: () => _toggleFavorite(offer["id"] as int),
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(230),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      offer["isFavorite"] == true ? Icons.favorite : Icons.favorite_border,
                      color: offer["isFavorite"] == true ? dangerColor : disabledBoldColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
              
              // Time Left
              Positioned(
                bottom: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(180),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.white,
                        size: 14,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${offer["timeLeft"]} left",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Content Section
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Rating
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${offer["title"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${offer["subtitle"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: warningColor,
                              size: 16,
                            ),
                            SizedBox(width: 2),
                            Text(
                              "${offer["rating"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "(${offer["reviews"]})",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Description
                Text(
                  "${offer["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: spSm),
                
                // Price Section
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "\$${((offer["salePrice"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "\$${((offer["originalPrice"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: disabledBoldColor,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "You save \$${(savingAmount).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Stock Progress
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Stock: ${offer["stock"]} left",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${offer["sold"]} sold",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: (offer["sold"] as int) / ((offer["sold"] as int) + (offer["stock"] as int)),
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        (offer["stock"] as int) < 50 ? dangerColor : successColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Tags and Features
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: [
                    ...(offer["tags"] as List).map((tag) => Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$tag",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )).toList(),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Action Button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Grab This Deal",
                    size: bs.md,
                    onPressed: () {
                      ss("Added to cart!");
                    },
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
        title: Text("Special Offers"),
        actions: [
          Icon(Icons.search, color: disabledBoldColor),
          SizedBox(width: spSm),
          Icon(Icons.filter_list, color: disabledBoldColor),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Sort By",
                          items: sortOptions,
                          value: selectedSortBy,
                          onChanged: (value, label) {
                            selectedSortBy = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Filter",
                          items: filterOptions,
                          value: selectedFilter,
                          onChanged: (value, label) {
                            selectedFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Show only favorites",
                        "value": true,
                        "checked": showOnlyFavorites,
                      }
                    ],
                    value: [if (showOnlyFavorites) {"label": "Show only favorites", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      showOnlyFavorites = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Results Header
            Row(
              children: [
                Text(
                  "Special Offers",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredOffers.length} offers",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Offers List
            if (filteredOffers.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.local_offer,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No Offers Found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters to see more offers",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: filteredOffers.map((offer) => _buildOfferCard(offer)).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
