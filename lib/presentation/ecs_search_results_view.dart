import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsSearchResultsView extends StatefulWidget {
  const EcsSearchResultsView({super.key});

  @override
  State<EcsSearchResultsView> createState() => _EcsSearchResultsViewState();
}

class _EcsSearchResultsViewState extends State<EcsSearchResultsView> {
  String searchQuery = "Bluetooth headphones";
  String selectedView = "grid"; // grid or list
  String sortBy = "relevance";
  bool isFilterApplied = false;
  bool loading = false;
  
  List<Map<String, dynamic>> searchResults = [
    {
      "id": 1,
      "name": "Sony WH-1000XM4 Wireless Bluetooth Headphones",
      "brand": "Sony",
      "price": 299.99,
      "original_price": 349.99,
      "rating": 4.8,
      "reviews_count": 2456,
      "image": "https://picsum.photos/300/300?random=1&keyword=headphones",
      "badge": "Best Seller",
      "free_shipping": true,
      "in_stock": true,
    },
    {
      "id": 2,
      "name": "Bose QuietComfort 45 Bluetooth Headphones",
      "brand": "Bose",
      "price": 279.99,
      "original_price": 329.99,
      "rating": 4.7,
      "reviews_count": 1893,
      "image": "https://picsum.photos/300/300?random=2&keyword=headphones",
      "badge": "Editor's Choice",
      "free_shipping": true,
      "in_stock": true,
    },
    {
      "id": 3,
      "name": "Apple AirPods Max - Sky Blue",
      "brand": "Apple",
      "price": 479.99,
      "original_price": 549.99,
      "rating": 4.6,
      "reviews_count": 987,
      "image": "https://picsum.photos/300/300?random=3&keyword=headphones",
      "badge": "Premium",
      "free_shipping": true,
      "in_stock": false,
    },
    {
      "id": 4,
      "name": "JBL Live 650BTNC Wireless Headphones",
      "brand": "JBL",
      "price": 129.99,
      "original_price": 179.99,
      "rating": 4.4,
      "reviews_count": 1234,
      "image": "https://picsum.photos/300/300?random=4&keyword=headphones",
      "badge": "Budget Pick",
      "free_shipping": false,
      "in_stock": true,
    },
    {
      "id": 5,
      "name": "Sennheiser HD 450BT Wireless Headphones",
      "brand": "Sennheiser", 
      "price": 149.99,
      "original_price": 199.99,
      "rating": 4.5,
      "reviews_count": 756,
      "image": "https://picsum.photos/300/300?random=5&keyword=headphones",
      "badge": "",
      "free_shipping": true,
      "in_stock": true,
    },
    {
      "id": 6,
      "name": "Audio-Technica ATH-M50xBT2 Wireless Headphones",
      "brand": "Audio-Technica",
      "price": 199.99,
      "original_price": 249.99,
      "rating": 4.7,
      "reviews_count": 892,
      "image": "https://picsum.photos/300/300?random=6&keyword=headphones",
      "badge": "Professional",
      "free_shipping": true,
      "in_stock": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Search Results",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "\"$searchQuery\"",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(selectedView == "grid" ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              selectedView = selectedView == "grid" ? "list" : "grid";
              setState(() {});
            },
          ),
        ],
      ),
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search products...",
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
                  onPressed: () => _performSearch(),
                ),
              ],
            ),
          ),

          // Filter and Sort Bar
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${searchResults.length} products found",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _showFilterOptions(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: isFilterApplied ? primaryColor : Colors.white,
                          border: Border.all(
                            color: isFilterApplied ? primaryColor : disabledOutlineBorderColor,
                          ),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.filter_list,
                              size: 16,
                              color: isFilterApplied ? Colors.white : disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Filter",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isFilterApplied ? Colors.white : disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () => _showSortOptions(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.sort,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Sort",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Results List
          Expanded(
            child: selectedView == "grid" 
              ? _buildGridView() 
              : _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: ResponsiveGridView(
        padding: EdgeInsets.zero,
        minItemWidth: 160,
        children: searchResults.map((product) {
          return _buildProductCard(product);
        }).toList(),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final product = searchResults[index];
        return _buildProductListItem(product);
      },
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${product["image"]}",
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              
              // Badge
              if ("${product["badge"]}".isNotEmpty)
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spXs,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${product["badge"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

              // Wishlist
              Positioned(
                top: spSm,
                right: spSm,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [shadowSm],
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Product Info
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${product["brand"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                
                Text(
                  "${product["name"]}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),

                // Rating
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: warningColor,
                      size: 12,
                    ),
                    SizedBox(width: 2),
                    Text(
                      "${product["rating"]}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "(${product["reviews_count"]})",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),

                // Price
                Row(
                  children: [
                    Text(
                      "\$${(product["price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if ((product["original_price"] as double) > (product["price"] as double)) ...[
                      SizedBox(width: spXs),
                      Text(
                        "\$${(product["original_price"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),

                // Stock Status
                if (!(product["in_stock"] as bool))
                  Container(
                    margin: EdgeInsets.only(top: spXs),
                    child: Text(
                      "Out of Stock",
                      style: TextStyle(
                        fontSize: 11,
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                // Free Shipping
                if (product["free_shipping"] as bool)
                  Container(
                    margin: EdgeInsets.only(top: spXs),
                    child: Text(
                      "Free Shipping",
                      style: TextStyle(
                        fontSize: 11,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductListItem(Map<String, dynamic> product) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          // Product Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${product["image"]}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              
              if ("${product["badge"]}".isNotEmpty)
                Positioned(
                  top: spXs,
                  left: spXs,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spXs,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${product["badge"]}",
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(width: spMd),

          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${product["brand"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                
                Text(
                  "${product["name"]}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),

                // Rating
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: warningColor,
                      size: 14,
                    ),
                    SizedBox(width: 2),
                    Text(
                      "${product["rating"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "(${product["reviews_count"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),

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
                    if ((product["original_price"] as double) > (product["price"] as double)) ...[
                      SizedBox(width: spXs),
                      Text(
                        "\$${(product["original_price"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),

                // Stock Status and Shipping
                Row(
                  children: [
                    if (!(product["in_stock"] as bool))
                      Text(
                        "Out of Stock",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    else if (product["free_shipping"] as bool)
                      Text(
                        "Free Shipping",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Actions
          Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [shadowSm],
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    size: 20,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              SizedBox(height: spSm),
              QButton(
                icon: Icons.add_shopping_cart,
                size: bs.sm,
                onPressed: (product["in_stock"] as bool) ? () {} : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _performSearch() {
    loading = true;
    setState(() {});
    
    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      loading = false;
      setState(() {});
      ss("Search completed for: $searchQuery");
    });
  }

  void _showFilterOptions() {
    // Navigate to filter page
    ss("Opening filter options");
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Sort By",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              
              ...[
                {"label": "Relevance", "value": "relevance"},
                {"label": "Price: Low to High", "value": "price_asc"},
                {"label": "Price: High to Low", "value": "price_desc"},
                {"label": "Customer Rating", "value": "rating"},
                {"label": "Newest First", "value": "newest"},
                {"label": "Best Sellers", "value": "popular"},
              ].map((option) {
                return GestureDetector(
                  onTap: () {
                    sortBy = "${option["value"]}";
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text("${option["label"]}"),
                        ),
                        if (sortBy == option["value"])
                          Icon(Icons.check, color: primaryColor),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
