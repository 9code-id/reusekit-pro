import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlEmptyState7View extends StatefulWidget {
  @override
  State<GrlEmptyState7View> createState() => _GrlEmptyState7ViewState();
}

class _GrlEmptyState7ViewState extends State<GrlEmptyState7View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Results"),
        actions: [
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            SizedBox(height: 40),
            
            // Search Illustration
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                color: infoColor.withAlpha(15),
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.search,
                    size: 80,
                    color: infoColor.withAlpha(60),
                  ),
                  Positioned(
                    bottom: 40,
                    right: 40,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: warningColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Title
            Text(
              "No results found",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Search Query Display
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: spMd,
                vertical: spSm,
              ),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.search,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "artificial intelligence",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Description
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Text(
                "We couldn't find anything matching your search. Try adjusting your search terms or browse our suggestions below.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                  height: 1.5,
                ),
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Search Suggestions
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
                        Icons.tips_and_updates,
                        color: warningColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Search Tips",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  _buildSearchTip("Check your spelling"),
                  _buildSearchTip("Use more general terms"),
                  _buildSearchTip("Try different keywords"),
                  _buildSearchTip("Use fewer search terms"),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Popular Searches
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
                    "Popular Searches",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: [
                      _buildSearchChip("machine learning", successColor),
                      _buildSearchChip("web development", infoColor),
                      _buildSearchChip("mobile apps", warningColor),
                      _buildSearchChip("data science", dangerColor),
                      _buildSearchChip("cloud computing", primaryColor),
                      _buildSearchChip("cybersecurity", successColor),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Categories
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
                    "Browse by Category",
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
                        "Technology",
                        Icons.computer,
                        primaryColor,
                      ),
                      _buildCategoryCard(
                        "Business",
                        Icons.business,
                        successColor,
                      ),
                      _buildCategoryCard(
                        "Design",
                        Icons.palette,
                        warningColor,
                      ),
                      _buildCategoryCard(
                        "Science",
                        Icons.science,
                        infoColor,
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
                label: "Try New Search",
                size: bs.md,
                onPressed: () {
                  // Focus search field or navigate to search
                },
              ),
            ),
            
            SizedBox(height: spMd),
            
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Browse All",
                    size: bs.md,
                    onPressed: () {
                      // navigateTo(BrowseAllView());
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: "Clear Filters",
                    size: bs.md,
                    onPressed: () {
                      // Clear search filters
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

  Widget _buildSearchTip(String tip) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: warningColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchChip(String term, Color color) {
    return GestureDetector(
      onTap: () {
        // Perform search with this term
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: spMd,
          vertical: spSm,
        ),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: color.withAlpha(60),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              term,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            SizedBox(width: spXs),
            Icon(
              Icons.search,
              size: 14,
              color: color,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        // Navigate to category
      },
      child: Container(
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
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
