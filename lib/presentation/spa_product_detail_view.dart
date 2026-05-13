import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaProductDetailView extends StatefulWidget {
  const SpaProductDetailView({super.key});

  @override
  State<SpaProductDetailView> createState() => _SpaProductDetailViewState();
}

class _SpaProductDetailViewState extends State<SpaProductDetailView> {
  int selectedImageIndex = 0;
  int quantity = 1;
  String selectedSize = "50ml";
  bool isFavorite = false;
  String selectedTab = "Description";
  
  List<String> productImages = [
    "https://picsum.photos/400/400?random=1&keyword=serum",
    "https://picsum.photos/400/400?random=2&keyword=skincare", 
    "https://picsum.photos/400/400?random=3&keyword=beauty",
    "https://picsum.photos/400/400?random=4&keyword=cosmetic",
  ];

  List<Map<String, dynamic>> sizes = [
    {"label": "30ml", "value": "30ml", "price": 69.99},
    {"label": "50ml", "value": "50ml", "price": 89.99},
    {"label": "100ml", "value": "100ml", "price": 159.99},
  ];

  Map<String, dynamic> product = {
    "name": "Hydrating Facial Serum",
    "brand": "LuxeSpa Premium",
    "category": "Skincare",
    "price": 89.99,
    "originalPrice": 120.00,
    "rating": 4.8,
    "reviews": 324,
    "isOnSale": true,
    "discount": 25,
    "inStock": true,
    "stockCount": 15,
    "tags": ["Bestseller", "Organic", "Cruelty-Free"],
    "description": "This premium hydrating serum is formulated with high-quality hyaluronic acid and vitamin C to provide deep moisturization and anti-aging benefits. Perfect for all skin types, this lightweight formula absorbs quickly without leaving any residue.",
    "ingredients": "Hyaluronic Acid, Vitamin C, Niacinamide, Peptides, Glycerin, Aqua",
    "howToUse": "Apply 2-3 drops to clean face morning and evening. Gently pat into skin until fully absorbed. Follow with moisturizer and sunscreen during the day.",
    "benefits": [
      "Deep hydration for up to 24 hours",
      "Reduces fine lines and wrinkles", 
      "Brightens and evens skin tone",
      "Suitable for sensitive skin",
      "Paraben-free and sulfate-free"
    ],
  };

  List<Map<String, dynamic>> reviews = [
    {
      "name": "Sarah Johnson",
      "rating": 5,
      "date": "2 days ago",
      "comment": "Amazing serum! My skin feels so hydrated and looks brighter after just one week of use.",
      "verified": true,
    },
    {
      "name": "Emma Wilson",
      "rating": 4,
      "date": "1 week ago", 
      "comment": "Good product but a bit pricey. The texture is nice and it absorbs well.",
      "verified": true,
    },
    {
      "name": "Lisa Chen",
      "rating": 5,
      "date": "2 weeks ago",
      "comment": "This serum has transformed my skin! Highly recommend for anyone with dry skin.",
      "verified": false,
    },
  ];

  List<Map<String, dynamic>> relatedProducts = [
    {
      "name": "Vitamin C Moisturizer",
      "brand": "LuxeSpa",
      "price": 45.99,
      "image": "https://picsum.photos/150/150?random=5&keyword=moisturizer",
      "rating": 4.6,
    },
    {
      "name": "Gentle Face Cleanser",
      "brand": "LuxeSpa",
      "price": 28.99,
      "image": "https://picsum.photos/150/150?random=6&keyword=cleanser",
      "rating": 4.7,
    },
    {
      "name": "Anti-Aging Eye Cream",
      "brand": "LuxeSpa",
      "price": 67.99,
      "image": "https://picsum.photos/150/150?random=7&keyword=eyecream",
      "rating": 4.5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? dangerColor : null,
            ),
            onPressed: () {
              isFavorite = !isFavorite;
              setState(() {});
              si(isFavorite ? "Added to favorites" : "Removed from favorites");
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              si("Product shared");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProductImages(),
            _buildProductInfo(),
            _buildSizeQuantitySelector(),
            _buildTabContent(),
            _buildRelatedProducts(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActions(),
    );
  }

  Widget _buildProductImages() {
    return Container(
      height: 400,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              child: Image.network(
                productImages[selectedImageIndex],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 80,
            padding: EdgeInsets.all(spSm),
            child: QHorizontalScroll(
              children: List.generate(productImages.length, (index) {
                return GestureDetector(
                  onTap: () {
                    selectedImageIndex = index;
                    setState(() {});
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: selectedImageIndex == index ? primaryColor : disabledOutlineBorderColor,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        productImages[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              ...((product["tags"] as List).map((tag) {
                return Container(
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "$tag",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                );
              }).toList()),
            ],
          ),
          Text(
            "${product["brand"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "${product["name"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 20),
              SizedBox(width: spXs),
              Text(
                "${product["rating"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                " (${product["reviews"]} reviews)",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "\$${(product["price"] as double).currency}",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              if (product["isOnSale"] == true) ...[
                SizedBox(width: spSm),
                Text(
                  "\$${(product["originalPrice"] as double).currency}",
                  style: TextStyle(
                    fontSize: 18,
                    color: disabledBoldColor,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "SAVE ${product["discount"]}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (product["inStock"] == true)
            Row(
              children: [
                Icon(Icons.check_circle, color: successColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "In Stock (${product["stockCount"]} left)",
                  style: TextStyle(
                    fontSize: 14,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          else
            Row(
              children: [
                Icon(Icons.cancel, color: dangerColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Out of Stock",
                  style: TextStyle(
                    fontSize: 14,
                    color: dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSizeQuantitySelector() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Size",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QCategoryPicker(
            items: sizes,
            value: selectedSize,
            onChanged: (index, label, value, item) {
              selectedSize = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Text(
            "Quantity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: quantity > 1 ? () {
                        quantity--;
                        setState(() {});
                      } : null,
                    ),
                    Container(
                      width: 40,
                      child: Text(
                        "$quantity",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        quantity++;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              Spacer(),
              Text(
                "Total: \$${((sizes.firstWhere((s) => s["value"] == selectedSize)["price"] as double) * quantity).currency}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    List<String> tabs = ["Description", "Ingredients", "Reviews"];
    
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: tabs.map((tab) {
                bool isSelected = selectedTab == tab;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = tab;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isSelected ? primaryColor : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        tab,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            child: _getTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _getTabContent() {
    switch (selectedTab) {
      case "Description":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Text(
              "${product["description"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Key Benefits:",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ...((product["benefits"] as List).map((benefit) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check, color: successColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "$benefit",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              );
            }).toList()),
          ],
        );
      case "Ingredients":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Text(
              "Active Ingredients:",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "${product["ingredients"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "How to Use:",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "${product["howToUse"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
          ],
        );
      case "Reviews":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Row(
              children: [
                Text(
                  "Customer Reviews",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Write Review",
                  size: bs.sm,
                  onPressed: () {
                    si("Write review");
                  },
                ),
              ],
            ),
            ...reviews.map((review) {
              return Container(
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${review["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        if (review["verified"] == true) ...[
                          SizedBox(width: spXs),
                          Icon(Icons.verified, color: successColor, size: 14),
                        ],
                        Spacer(),
                        Text(
                          "${review["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < (review["rating"] as int) ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 14,
                        );
                      }),
                    ),
                    Text(
                      "${review["comment"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        );
      default:
        return Container();
    }
  }

  Widget _buildRelatedProducts() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "You May Also Like",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: relatedProducts.map((product) {
              return Container(
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusSm),
                          topRight: Radius.circular(radiusSm),
                        ),
                        child: Image.network(
                          "${product["image"]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${product["brand"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${product["name"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 12),
                              SizedBox(width: 2),
                              Text(
                                "${product["rating"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "\$${(product["price"] as double).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
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
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusMd),
          topRight: Radius.circular(radiusMd),
        ),
        boxShadow: [shadowMd],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart_outlined, color: primaryColor),
              onPressed: () {
                si("Added to cart");
              },
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: "Buy Now - \$${((sizes.firstWhere((s) => s["value"] == selectedSize)["price"] as double) * quantity).currency}",
              size: bs.md,
              onPressed: () {
                ss("Purchase initiated");
              },
            ),
          ),
        ],
      ),
    );
  }
}
