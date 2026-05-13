import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlEmptyState4View extends StatefulWidget {
  @override
  State<GrlEmptyState4View> createState() => _GrlEmptyState4ViewState();
}

class _GrlEmptyState4ViewState extends State<GrlEmptyState4View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Library"),
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
            SizedBox(height: 40),
            
            // Library Illustration
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXl),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 30,
                    left: 40,
                    child: Transform.rotate(
                      angle: -0.2,
                      child: Container(
                        width: 60,
                        height: 80,
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(180),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.book,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 60,
                    child: Transform.rotate(
                      angle: 0.3,
                      child: Container(
                        width: 60,
                        height: 80,
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(180),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.menu_book,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.library_books,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Title and Description
            Text(
              "Your library is empty",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Text(
                "Discover amazing books, audiobooks, and e-books. Build your personal library and start your reading journey today.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                  height: 1.6,
                ),
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Book Categories
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
                    "Explore Genres",
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
                      _buildGenreChip("Fiction", successColor),
                      _buildGenreChip("Mystery", dangerColor),
                      _buildGenreChip("Romance", warningColor),
                      _buildGenreChip("Science Fiction", infoColor),
                      _buildGenreChip("Biography", primaryColor),
                      _buildGenreChip("Self-Help", successColor),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Reading Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.timer,
                          size: 32,
                          color: primaryColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "0 hrs",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Reading Time",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.book_online,
                          size: 32,
                          color: successColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "0",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Books Read",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.trending_up,
                          size: 32,
                          color: warningColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "0",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Streak",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spXl),
            
            // Action Buttons
            Container(
              width: double.infinity,
              child: QButton(
                label: "Browse Books",
                size: bs.md,
                onPressed: () {
                  // navigateTo(BookCatalogView());
                },
              ),
            ),
            
            SizedBox(height: spMd),
            
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Bestsellers",
                    size: bs.md,
                    onPressed: () {
                      // navigateTo(BestsellersView());
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: "Free Books",
                    size: bs.md,
                    onPressed: () {
                      // navigateTo(FreeBooksView());
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            Container(
              width: double.infinity,
              child: QButton(
                label: "Import Library",
                size: bs.md,
                onPressed: () {
                  // navigateTo(ImportLibraryView());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenreChip(String genre, Color color) {
    return Container(
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
      child: Text(
        genre,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
