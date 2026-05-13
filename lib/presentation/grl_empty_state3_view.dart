import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlEmptyState3View extends StatefulWidget {
  @override
  State<GrlEmptyState3View> createState() => _GrlEmptyState3ViewState();
}

class _GrlEmptyState3ViewState extends State<GrlEmptyState3View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            SizedBox(height: 60),
            
            // Shopping Cart Illustration
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(15),
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(30),
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(60),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.shopping_cart,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spXl),
            
            // Main Message
            Text(
              "Your cart is empty",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            Text(
              "Looks like you haven't added anything to your cart yet. Browse our products and find something you love!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Featured Categories
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Popular Categories",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ResponsiveGridView(
                    minItemWidth: 120,
                    children: [
                      _buildCategoryCard(
                        "Electronics",
                        Icons.phone_android,
                        successColor,
                      ),
                      _buildCategoryCard(
                        "Fashion",
                        Icons.checkroom,
                        warningColor,
                      ),
                      _buildCategoryCard(
                        "Home & Garden",
                        Icons.home,
                        infoColor,
                      ),
                      _buildCategoryCard(
                        "Sports",
                        Icons.sports_soccer,
                        dangerColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Special Offers
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [warningColor, warningColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.local_offer,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Special Offers",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Get 20% off on your first purchase",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Use code: WELCOME20",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Action Buttons
            Container(
              width: double.infinity,
              child: QButton(
                label: "Start Shopping",
                size: bs.md,
                onPressed: () {
                  // navigateTo(ProductListView());
                },
              ),
            ),
            
            SizedBox(height: spMd),
            
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Wishlist",
                    size: bs.md,
                    onPressed: () {
                      // navigateTo(WishlistView());
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: "Order History",
                    size: bs.md,
                    onPressed: () {
                      // navigateTo(OrderHistoryView());
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: color.withAlpha(60),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
            color: color,
          ),
          SizedBox(height: spSm),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
