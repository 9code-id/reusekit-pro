import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlEmptyState6View extends StatefulWidget {
  @override
  State<GrlEmptyState6View> createState() => _GrlEmptyState6ViewState();
}

class _GrlEmptyState6ViewState extends State<GrlEmptyState6View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            SizedBox(height: 50),
            
            // Heart Illustration
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(15),
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: dangerColor.withAlpha(60),
                  ),
                  Icon(
                    Icons.favorite,
                    size: 60,
                    color: dangerColor,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Title
            Text(
              "No favorites yet",
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
                "Items you mark as favorites will appear here. Start exploring and save the things you love!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                  height: 1.5,
                ),
              ),
            ),
            
            SizedBox(height: spXl),
            
            // How to Add Favorites
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
                        Icons.lightbulb,
                        color: warningColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "How to add favorites",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  _buildInstructionStep(
                    "1",
                    "Browse items",
                    "Explore products, articles, or content",
                    Icons.search,
                  ),
                  _buildInstructionStep(
                    "2",
                    "Tap the heart icon",
                    "Look for the ♡ icon on items you like",
                    Icons.favorite_border,
                  ),
                  _buildInstructionStep(
                    "3",
                    "Access anytime",
                    "Find all your favorites here instantly",
                    Icons.bookmark,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Categories to Explore
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
                    "Popular to favorite",
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
                        "Products",
                        Icons.shopping_bag,
                        primaryColor,
                        "2.5K+ items",
                      ),
                      _buildCategoryCard(
                        "Articles",
                        Icons.article,
                        successColor,
                        "1.8K+ posts",
                      ),
                      _buildCategoryCard(
                        "Videos",
                        Icons.play_circle,
                        dangerColor,
                        "900+ videos",
                      ),
                      _buildCategoryCard(
                        "Photos",
                        Icons.photo,
                        infoColor,
                        "5K+ images",
                      ),
                    ],
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
                        Icons.star,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Why use favorites?",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  _buildBenefitItem("Quick access to liked items"),
                  _buildBenefitItem("Create personal collections"),
                  _buildBenefitItem("Never lose track of good stuff"),
                  _buildBenefitItem("Share with friends easily"),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Action Buttons
            Container(
              width: double.infinity,
              child: QButton(
                label: "Start Exploring",
                size: bs.md,
                onPressed: () {
                  // navigateTo(ExploreView());
                },
              ),
            ),
            
            SizedBox(height: spMd),
            
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Popular Items",
                    size: bs.md,
                    onPressed: () {
                      // navigateTo(PopularItemsView());
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: "Trending Now",
                    size: bs.md,
                    onPressed: () {
                      // navigateTo(TrendingView());
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

  Widget _buildInstructionStep(String number, String title, String description, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
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
            color: primaryColor,
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, Color color, String count) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
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
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            count,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
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
            Icons.check_circle,
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
}
