import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsFlashSaleView extends StatefulWidget {
  const EcsFlashSaleView({super.key});

  @override
  State<EcsFlashSaleView> createState() => _EcsFlashSaleViewState();
}

class _EcsFlashSaleViewState extends State<EcsFlashSaleView> {
  DateTime flashSaleEndTime = DateTime.now().add(Duration(hours: 6, minutes: 23, seconds: 45));
  
  List<Map<String, dynamic>> flashSaleProducts = [
    {
      "id": 1,
      "title": "Gaming Laptop Pro",
      "originalPrice": 1299.99,
      "flashPrice": 699.99,
      "discount": 46,
      "image": "https://picsum.photos/400/400?random=1&keyword=laptop",
      "category": "Electronics",
      "rating": 4.8,
      "reviews": 2456,
      "soldCount": 89,
      "totalStock": 150,
      "isLimitedStock": true,
      "flashSaleOnly": true
    },
    {
      "id": 2,
      "title": "Designer Handbag",
      "originalPrice": 299.99,
      "flashPrice": 149.99,
      "discount": 50,
      "image": "https://picsum.photos/400/400?random=2&keyword=handbag",
      "category": "Fashion",
      "rating": 4.7,
      "reviews": 1834,
      "soldCount": 67,
      "totalStock": 100,
      "isLimitedStock": true,
      "flashSaleOnly": true
    },
    {
      "id": 3,
      "title": "Smart TV 55 inch",
      "originalPrice": 899.99,
      "flashPrice": 499.99,
      "discount": 44,
      "image": "https://picsum.photos/400/400?random=3&keyword=tv",
      "category": "Electronics",
      "rating": 4.6,
      "reviews": 956,
      "soldCount": 134,
      "totalStock": 200,
      "isLimitedStock": false,
      "flashSaleOnly": true
    },
    {
      "id": 4,
      "title": "Premium Skincare Set",
      "originalPrice": 199.99,
      "flashPrice": 89.99,
      "discount": 55,
      "image": "https://picsum.photos/400/400?random=4&keyword=skincare",
      "category": "Beauty",
      "rating": 4.9,
      "reviews": 1245,
      "soldCount": 178,
      "totalStock": 250,
      "isLimitedStock": true,
      "flashSaleOnly": true
    },
    {
      "id": 5,
      "title": "Wireless Air Purifier",
      "originalPrice": 449.99,
      "flashPrice": 229.99,
      "discount": 49,
      "image": "https://picsum.photos/400/400?random=5&keyword=purifier",
      "category": "Home",
      "rating": 4.5,
      "reviews": 678,
      "soldCount": 45,
      "totalStock": 80,
      "isLimitedStock": true,
      "flashSaleOnly": true
    },
    {
      "id": 6,
      "title": "Professional Camera",
      "originalPrice": 799.99,
      "flashPrice": 449.99,
      "discount": 44,
      "image": "https://picsum.photos/400/400?random=6&keyword=camera",
      "category": "Electronics",
      "rating": 4.8,
      "reviews": 567,
      "soldCount": 23,
      "totalStock": 50,
      "isLimitedStock": true,
      "flashSaleOnly": true
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flash Sale"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              //share flash sale
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
            _buildFlashSaleHeader(),
            _buildCountdownTimer(),
            _buildFlashSaleStats(),
            _buildHowItWorks(),
            _buildFeaturedProduct(),
            _buildFlashSaleGrid(),
            _buildUpcomingSale(),
          ],
        ),
      ),
    );
  }

  Widget _buildFlashSaleHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            dangerColor,
            dangerColor.withAlpha(180),
          ],
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.flash_on, color: Colors.white, size: 32),
              SizedBox(width: spSm),
              Text(
                "FLASH SALE",
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "LIMITED TIME OFFERS",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.w600,
              color: Colors.white.withAlpha(220),
              letterSpacing: 1.0,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Up to 55% OFF on selected items",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownTimer() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: dangerColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.schedule, color: dangerColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Sale Ends In",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTimeUnit("06", "Hours"),
              _buildTimeUnit("23", "Minutes"),
              _buildTimeUnit("45", "Seconds"),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "⚡ Don't miss out! Prices will return to normal after timer ends",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: dangerColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeUnit(String value, String label) {
    return Column(
      spacing: spXs,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
          decoration: BoxDecoration(
            color: dangerColor,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildFlashSaleStats() {
    int totalProducts = flashSaleProducts.length;
    int soldProducts = flashSaleProducts.fold(0, (sum, product) => sum + (product["soldCount"] as int));
    double avgDiscount = flashSaleProducts.fold(0.0, (sum, product) => sum + (product["discount"] as int)) / totalProducts;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem("Products", "${totalProducts}", Icons.inventory, primaryColor),
          ),
          Container(width: 1, height: 40, color: disabledColor),
          Expanded(
            child: _buildStatItem("Sold", "${soldProducts}", Icons.shopping_cart, successColor),
          ),
          Container(width: 1, height: 40, color: disabledColor),
          Expanded(
            child: _buildStatItem("Avg Save", "${avgDiscount.toInt()}%", Icons.savings, warningColor),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      spacing: spXs,
      children: [
        Icon(icon, color: color, size: 24),
        Text(
          value,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildHowItWorks() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: infoColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: infoColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "How Flash Sale Works",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          Column(
            spacing: spXs,
            children: [
              _buildHowItWorksStep("1", "Limited time offer with huge discounts"),
              _buildHowItWorksStep("2", "Stock is limited - first come, first served"),
              _buildHowItWorksStep("3", "Prices return to normal after timer ends"),
              _buildHowItWorksStep("4", "Multiple flash sales throughout the day"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHowItWorksStep(String number, String description) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: infoColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedProduct() {
    Map<String, dynamic> featured = flashSaleProducts.first;
    double progressValue = (featured["soldCount"] as int) / (featured["totalStock"] as int);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "⭐ Featured Flash Deal",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowMd],
            border: Border.all(color: warningColor.withAlpha(100)),
          ),
          child: Column(
            spacing: spMd,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${featured["image"]}",
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "${featured["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < (featured["rating"] as double).floor() 
                                      ? Icons.star 
                                      : Icons.star_border,
                                  color: warningColor,
                                  size: 16,
                                );
                              }),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${featured["rating"]} (${featured["reviews"]})",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "\$${((featured["originalPrice"] as double).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                color: disabledBoldColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "\$${((featured["flashPrice"] as double).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: dangerColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "SAVE ${featured["discount"]}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                spacing: spXs,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sold: ${featured["soldCount"]}/${featured["totalStock"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${(progressValue * 100).toInt()}% claimed",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: progressValue,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(dangerColor),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Buy Now - Flash Price",
                  size: bs.md,
                  onPressed: () {
                    //navigateTo EcsProductDetailView
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFlashSaleGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "All Flash Sale Products",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: flashSaleProducts.skip(1).map((product) {
            return _buildFlashProductCard(product);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFlashProductCard(Map<String, dynamic> product) {
    double progressValue = (product["soldCount"] as int) / (product["totalStock"] as int);
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${product["image"]}",
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
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
                    "⚡${product["discount"]}% OFF",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              if (product["isLimitedStock"])
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: warningColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "LIMITED",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
              spacing: spSm,
              children: [
                Text(
                  "${product["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      "\$${((product["originalPrice"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "\$${((product["flashPrice"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < (product["rating"] as double).floor() 
                              ? Icons.star 
                              : Icons.star_border,
                          color: warningColor,
                          size: 14,
                        );
                      }),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${product["rating"]} (${product["reviews"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: spXs,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${product["soldCount"]} sold",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${((product["totalStock"] as int) - (product["soldCount"] as int))} left",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: progressValue,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(dangerColor),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Flash Buy",
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo EcsProductDetailView
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

  Widget _buildUpcomingSale() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: secondaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: secondaryColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.upcoming, color: secondaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Next Flash Sale",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: secondaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Next flash sale starts in 2 hours",
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "Get notified when it starts!",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Set Reminder",
              size: bs.sm,
              onPressed: () {
                ss("Reminder set! You'll be notified when the next flash sale starts.");
              },
            ),
          ),
        ],
      ),
    );
  }
}
