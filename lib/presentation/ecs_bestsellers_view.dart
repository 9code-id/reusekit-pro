import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsBestsellersView extends StatefulWidget {
  const EcsBestsellersView({super.key});

  @override
  State<EcsBestsellersView> createState() => _EcsBestsellersViewState();
}

class _EcsBestsellersViewState extends State<EcsBestsellersView> {
  String selectedCategory = "All";
  String selectedPeriod = "This Month";
  String sortBy = "Sales Volume";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Fashion", "value": "Fashion"},
    {"label": "Home & Garden", "value": "Home & Garden"},
    {"label": "Beauty", "value": "Beauty"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Books", "value": "Books"},
  ];

  List<Map<String, dynamic>> periods = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "This Year", "value": "This Year"},
    {"label": "All Time", "value": "All Time"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Sales Volume", "value": "Sales Volume"},
    {"label": "Revenue Generated", "value": "Revenue Generated"},
    {"label": "Customer Rating", "value": "Customer Rating"},
    {"label": "Price: Low to High", "value": "Price: Low to High"},
    {"label": "Price: High to Low", "value": "Price: High to Low"},
  ];

  List<Map<String, dynamic>> bestsellers = [
    {
      "id": 1,
      "name": "Wireless Noise-Cancelling Headphones",
      "price": 299.99,
      "originalPrice": 399.99,
      "image": "https://picsum.photos/300/300?random=1&keyword=headphones",
      "rating": 4.8,
      "reviews": 5247,
      "category": "Electronics",
      "rank": 1,
      "unitsSold": 12450,
      "revenue": 3735000.0,
      "salesGrowth": 23.5,
      "badge": "#1 Bestseller",
      "badgeColor": Colors.red,
      "availability": "In Stock",
      "shippingInfo": "Free shipping",
    },
    {
      "id": 2,
      "name": "Premium Skincare Bundle",
      "price": 149.99,
      "originalPrice": 220.00,
      "image": "https://picsum.photos/300/300?random=2&keyword=skincare",
      "rating": 4.9,
      "reviews": 8934,
      "category": "Beauty",
      "rank": 2,
      "unitsSold": 8960,
      "revenue": 1344000.0,
      "salesGrowth": 18.2,
      "badge": "Top Rated",
      "badgeColor": Colors.green,
      "availability": "In Stock",
      "shippingInfo": "Free shipping",
    },
    {
      "id": 3,
      "name": "Smart Fitness Tracker",
      "price": 199.99,
      "originalPrice": 249.99,
      "image": "https://picsum.photos/300/300?random=3&keyword=fitness",
      "rating": 4.7,
      "reviews": 3456,
      "category": "Electronics",
      "rank": 3,
      "unitsSold": 6780,
      "revenue": 1356000.0,
      "salesGrowth": 15.8,
      "badge": "Hot Item",
      "badgeColor": Colors.orange,
      "availability": "Low Stock",
      "shippingInfo": "2-day delivery",
    },
    {
      "id": 4,
      "name": "Designer Casual Sneakers",
      "price": 129.99,
      "originalPrice": 179.99,
      "image": "https://picsum.photos/300/300?random=4&keyword=sneakers",
      "rating": 4.6,
      "reviews": 2145,
      "category": "Fashion",
      "rank": 4,
      "unitsSold": 5940,
      "revenue": 772000.0,
      "salesGrowth": 12.3,
      "badge": "Customer Choice",
      "badgeColor": primaryColor,
      "availability": "In Stock",
      "shippingInfo": "Free shipping",
    },
    {
      "id": 5,
      "name": "Organic Coffee Maker",
      "price": 89.99,
      "originalPrice": 129.99,
      "image": "https://picsum.photos/300/300?random=5&keyword=coffee",
      "rating": 4.8,
      "reviews": 1876,
      "category": "Home & Garden",
      "rank": 5,
      "unitsSold": 4320,
      "revenue": 388800.0,
      "salesGrowth": 9.7,
      "badge": "Editor's Pick",
      "badgeColor": Colors.purple,
      "availability": "In Stock",
      "shippingInfo": "Free shipping",
    },
    {
      "id": 6,
      "name": "Professional Yoga Mat Set",
      "price": 59.99,
      "originalPrice": 89.99,
      "image": "https://picsum.photos/300/300?random=6&keyword=yoga",
      "rating": 4.7,
      "reviews": 2987,
      "category": "Sports",
      "rank": 6,
      "unitsSold": 7650,
      "revenue": 458850.0,
      "salesGrowth": 21.4,
      "badge": "Rising Star",
      "badgeColor": Colors.cyan,
      "availability": "In Stock",
      "shippingInfo": "Free shipping",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bestsellers"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_list),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.analytics),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bestsellers Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withAlpha(20),
                    Colors.white,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.local_fire_department,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Top Bestsellers",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Most popular products based on sales",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  // Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          "46.2K",
                          "Total Units",
                          Icons.shopping_bag,
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "\$8.05M",
                          "Total Revenue",
                          Icons.attach_money,
                          successColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "4.8",
                          "Avg Rating",
                          Icons.star,
                          Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Filter Section
            Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Filter & Sort",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categories,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Time Period",
                        items: periods,
                        value: selectedPeriod,
                        onChanged: (value, label) {
                          selectedPeriod = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QDropdownField(
                  label: "Sort By",
                  items: sortOptions,
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Bestsellers List
            Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Bestselling Products",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${bestsellers.length} products",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                // Top 3 Bestsellers (Featured)
                Column(
                  spacing: spSm,
                  children: bestsellers.take(3).map((product) {
                    return _buildFeaturedBestsellerCard(product);
                  }).toList(),
                ),

                SizedBox(height: spSm),

                // Other Bestsellers (Grid)
                if (bestsellers.length > 3) ...[
                  Text(
                    "Other Top Sellers",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: bestsellers.skip(3).map((product) {
                      return _buildBestsellerCard(product);
                    }).toList(),
                  ),
                ],
              ],
            ),

            // Sales Performance Chart
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sales Performance Trends",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 120,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(7, (index) {
                        final heights = [40.0, 60.0, 80.0, 100.0, 75.0, 90.0, 85.0];
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: heights[index],
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [primaryColor, primaryColor.withAlpha(150)],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][index],
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedBestsellerCard(Map<String, dynamic> product) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
        border: Border.all(
          color: product["rank"] == 1 ? Colors.red.withAlpha(100) : primaryColor.withAlpha(50),
          width: product["rank"] == 1 ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          // Rank Badge
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: product["rank"] == 1 ? Colors.red : 
                     product["rank"] == 2 ? Colors.orange : 
                     Colors.amber,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Center(
              child: Text(
                "#${product["rank"]}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),

          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${product["image"]}",
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spSm),

          // Product Info
          Expanded(
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${product["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: product["badgeColor"],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${product["badge"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Text(
                      "\$${(product["price"] as double).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 14,
                    ),
                    Text(
                      " ${product["rating"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Text(
                      "${((product["unitsSold"] as int) / 1000).toStringAsFixed(1)}K sold",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "+${(product["salesGrowth"] as double).toStringAsFixed(1)}%",
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

          // Action Button
          QButton(
            label: "Buy Now",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBestsellerCard(Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image with Rank
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${product["image"]}",
                  height: 150,
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
                    color: Colors.black.withAlpha(180),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "#${product["rank"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
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
                    color: product["badgeColor"],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${product["badge"]}",
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

          // Product Info
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${product["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                Text(
                  "\$${(product["price"] as double).currency}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
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

                Text(
                  "${((product["unitsSold"] as int) / 1000).toStringAsFixed(1)}K units sold",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Add to Cart",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
