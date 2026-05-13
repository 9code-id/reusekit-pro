import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlEmptyState8View extends StatefulWidget {
  @override
  State<GrlEmptyState8View> createState() => _GrlEmptyState8ViewState();
}

class _GrlEmptyState8ViewState extends State<GrlEmptyState8View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            SizedBox(height: 30),
            
            // Package Illustration
            Container(
              width: 180,
              height: 180,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 160,
                    height: 120,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                  ),
                  Container(
                    width: 140,
                    height: 100,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(40),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 80,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.shopping_bag,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: successColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Title
            Text(
              "No orders yet",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Description
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Text(
                "You haven't placed any orders yet. Start shopping to see your order history here.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                  height: 1.5,
                ),
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Order Process Steps
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
                  Row(
                    children: [
                      Icon(
                        Icons.timeline,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "How ordering works",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  _buildOrderStep(
                    1,
                    "Browse Products",
                    "Find items you love",
                    Icons.search,
                    primaryColor,
                  ),
                  _buildOrderStep(
                    2,
                    "Add to Cart",
                    "Select quantity and options",
                    Icons.add_shopping_cart,
                    warningColor,
                  ),
                  _buildOrderStep(
                    3,
                    "Checkout",
                    "Enter shipping and payment info",
                    Icons.payment,
                    infoColor,
                  ),
                  _buildOrderStep(
                    4,
                    "Track & Receive",
                    "Monitor delivery status",
                    Icons.local_shipping,
                    successColor,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Benefits Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(180)],
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
                        Icons.verified,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Why shop with us?",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  _buildBenefitItem("Free shipping on orders over \$50"),
                  _buildBenefitItem("30-day return guarantee"),
                  _buildBenefitItem("24/7 customer support"),
                  _buildBenefitItem("Secure payment processing"),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Order Status Info
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
                    "Order Status Types",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatusCard(
                          "Processing",
                          Icons.sync,
                          warningColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatusCard(
                          "Shipped",
                          Icons.local_shipping,
                          infoColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatusCard(
                          "Delivered",
                          Icons.check_circle,
                          successColor,
                        ),
                      ),
                    ],
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
                  // navigateTo(ShopView());
                },
              ),
            ),
            
            SizedBox(height: spMd),
            
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Catalog",
                    size: bs.md,
                    onPressed: () {
                      // navigateTo(CatalogView());
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: "Best Sellers",
                    size: bs.md,
                    onPressed: () {
                      // navigateTo(BestSellersView());
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

  Widget _buildOrderStep(int number, String title, String description, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "$number",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            icon,
            color: color,
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(
            Icons.check,
            color: Colors.white,
            size: 16,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(String status, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(60),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 24,
            color: color,
          ),
          SizedBox(height: spXs),
          Text(
            status,
            textAlign: TextAlign.center,
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
