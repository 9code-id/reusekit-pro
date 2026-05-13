import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaGameInfoView extends StatefulWidget {
  const GeaGameInfoView({super.key});

  @override
  State<GeaGameInfoView> createState() => _GeaGameInfoViewState();
}

class _GeaGameInfoViewState extends State<GeaGameInfoView> {
  int selectedTab = 0;
  bool isFavorite = false;
  bool isWishlisted = true;

  Map<String, dynamic> gameInfo = {
    "id": "1",
    "title": "Dragon's Quest: Legends",
    "developer": "Epic Studios",
    "publisher": "GameCorp Entertainment",
    "category": "RPG",
    "rating": 4.8,
    "reviews": 125430,
    "downloads": 2500000,
    "price": 29.99,
    "originalPrice": 39.99,
    "discount": 25,
    "releaseDate": "2024-03-15",
    "lastUpdate": "2024-06-10",
    "version": "2.1.4",
    "size": "4.2 GB",
    "minAge": "13+",
    "description": "Embark on an epic adventure in Dragon's Quest: Legends, where ancient mysteries await and legendary creatures roam the land. Customize your hero, master powerful spells, and forge alliances in this immersive RPG experience.",
    "features": [
      "Epic single-player campaign spanning 80+ hours",
      "Dynamic character customization system",
      "Real-time combat with spell combinations",
      "Multiplayer co-op for up to 4 players",
      "Rich crafting and enchantment system",
    ],
    "screenshots": [
      "https://picsum.photos/400/300?random=1&keyword=fantasy",
      "https://picsum.photos/400/300?random=2&keyword=dragon",
      "https://picsum.photos/400/300?random=3&keyword=castle",
      "https://picsum.photos/400/300?random=4&keyword=warrior",
      "https://picsum.photos/400/300?random=5&keyword=magic",
    ],
    "gameplayVideo": "https://picsum.photos/400/300?random=6&keyword=gameplay",
    "requirements": {
      "os": "Windows 10 64-bit",
      "processor": "Intel i5-8400 / AMD Ryzen 5 2600",
      "memory": "8 GB RAM",
      "graphics": "GTX 1060 6GB / RX 580 8GB",
      "storage": "50 GB available space",
    },
    "languages": ["English", "Spanish", "French", "German", "Japanese", "Korean"],
    "esrbRating": "Teen",
    "inAppPurchases": true,
  };

  List<Map<String, dynamic>> reviews = [
    {
      "id": "1",
      "userName": "GamerPro123",
      "rating": 5,
      "date": "2024-06-15",
      "title": "Absolutely Amazing!",
      "content": "This game exceeded all my expectations. The story is engaging, the graphics are stunning, and the gameplay is incredibly smooth. Worth every penny!",
      "likes": 23,
      "verified": true,
    },
    {
      "id": "2",
      "userName": "RPGFan87",
      "rating": 4,
      "date": "2024-06-12",
      "title": "Great RPG Experience",
      "content": "Solid RPG with great character development. The combat system takes some getting used to, but once you master it, it's very rewarding.",
      "likes": 15,
      "verified": false,
    },
    {
      "id": "3",
      "userName": "CasualGamer",
      "rating": 5,
      "date": "2024-06-10",
      "title": "Perfect for beginners",
      "content": "Never played an RPG before, but this game made it easy to learn. The tutorial is excellent and the difficulty curve is just right.",
      "likes": 31,
      "verified": true,
    },
  ];

  List<Map<String, dynamic>> relatedGames = [
    {
      "title": "Mystic Warriors",
      "developer": "Epic Studios",
      "rating": 4.6,
      "price": 24.99,
      "image": "https://picsum.photos/150/150?random=7&keyword=warrior",
    },
    {
      "title": "Shadow Realm",
      "developer": "Dark Games",
      "rating": 4.4,
      "price": 19.99,
      "image": "https://picsum.photos/150/150?random=8&keyword=shadow",
    },
    {
      "title": "Kingdom Hearts",
      "developer": "Fantasy Studios",
      "rating": 4.7,
      "price": 34.99,
      "image": "https://picsum.photos/150/150?random=9&keyword=kingdom",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with Screenshots
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  child: QHorizontalScroll(
                    children: List.generate((gameInfo["screenshots"] as List).length, (index) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("${(gameInfo["screenshots"] as List)[index]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                
                // Gradient Overlay
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withAlpha(200),
                      ],
                    ),
                  ),
                ),
                
                // AppBar
                Positioned(
                  top: 40,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => back(),
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(100),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            isFavorite = !isFavorite;
                            setState(() {});
                            ss(isFavorite ? "Added to favorites" : "Removed from favorites");
                          },
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(100),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? dangerColor : Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        GestureDetector(
                          onTap: () {
                            si("Share game");
                          },
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(100),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Game Title and Basic Info
                Positioned(
                  bottom: spMd,
                  left: spMd,
                  right: spMd,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${gameInfo["title"]}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Text(
                            "${gameInfo["developer"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${gameInfo["category"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Rating and Price Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        // Rating
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: warningColor,
                                  size: 20,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${gameInfo["rating"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${((gameInfo["reviews"] as int) / 1000).toInt()}K reviews",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        
                        // Downloads
                        Column(
                          children: [
                            Text(
                              "${((gameInfo["downloads"] as int) / 1000000).toStringAsFixed(1)}M",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Downloads",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        
                        // Price
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if ((gameInfo["discount"] as int) > 0) ...[
                              Text(
                                "\$${(gameInfo["originalPrice"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "-${gameInfo["discount"]}%",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "\$${(gameInfo["price"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ] else ...[
                              Text(
                                "\$${(gameInfo["price"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: QButton(
                          label: "Buy Now",
                          size: bs.md,
                          onPressed: () {
                            ss("Purchasing ${gameInfo["title"]}");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: QButton(
                          icon: isWishlisted ? Icons.bookmark : Icons.bookmark_border,
                          size: bs.md,
                          onPressed: () {
                            isWishlisted = !isWishlisted;
                            setState(() {});
                            ss(isWishlisted ? "Added to wishlist" : "Removed from wishlist");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: QButton(
                          icon: Icons.download,
                          size: bs.md,
                          onPressed: () {
                            si("Download demo");
                          },
                        ),
                      ),
                    ],
                  ),

                  // Content Tabs
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  selectedTab = 0;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: spSm),
                                  decoration: BoxDecoration(
                                    color: selectedTab == 0 ? primaryColor : Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(radiusMd),
                                    ),
                                  ),
                                  child: Text(
                                    "Overview",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: selectedTab == 0 ? Colors.white : disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  selectedTab = 1;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: spSm),
                                  decoration: BoxDecoration(
                                    color: selectedTab == 1 ? primaryColor : Colors.transparent,
                                  ),
                                  child: Text(
                                    "Reviews",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: selectedTab == 1 ? Colors.white : disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  selectedTab = 2;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: spSm),
                                  decoration: BoxDecoration(
                                    color: selectedTab == 2 ? primaryColor : Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(radiusMd),
                                    ),
                                  ),
                                  child: Text(
                                    "Details",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: selectedTab == 2 ? Colors.white : disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(spMd),
                          child: _buildTabContent(),
                        ),
                      ],
                    ),
                  ),

                  // Related Games
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "You might also like",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        QHorizontalScroll(
                          children: List.generate(relatedGames.length, (index) {
                            final game = relatedGames[index];
                            return Container(
                              width: 150,
                              margin: EdgeInsets.only(right: spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    child: Image.network(
                                      "${game["image"]}",
                                      width: double.infinity,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${game["title"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "${game["developer"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: warningColor,
                                        size: 12,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "${game["rating"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "\$${(game["price"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ],
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

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return _buildOverviewTab();
      case 1:
        return _buildReviewsTab();
      case 2:
        return _buildDetailsTab();
      default:
        return _buildOverviewTab();
    }
  }

  Widget _buildOverviewTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "About this game",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "${gameInfo["description"]}",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
            height: 1.5,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Key Features",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...(gameInfo["features"] as List<String>).map((feature) {
          return Padding(
            padding: EdgeInsets.only(bottom: spXs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle,
                  color: successColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    feature,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildReviewsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Text(
              "Reviews",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              label: "Write Review",
              size: bs.sm,
              onPressed: () {
                si("Write a review");
              },
            ),
          ],
        ),
        ...reviews.map((review) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: disabledOutlineBorderColor,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "${review["userName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (review["verified"] as bool) ...[
                      SizedBox(width: spXs),
                      Icon(
                        Icons.verified,
                        color: primaryColor,
                        size: 14,
                      ),
                    ],
                    Spacer(),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < (review["rating"] as int) ? Icons.star : Icons.star_border,
                          color: warningColor,
                          size: 14,
                        );
                      }),
                    ),
                  ],
                ),
                Text(
                  "${review["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${review["content"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Posted ${DateTime.parse(review["date"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.thumb_up,
                          color: primaryColor,
                          size: 12,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${review["likes"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildDetailsTab() {
    final requirements = gameInfo["requirements"] as Map<String, dynamic>;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        _buildDetailSection("Game Information", [
          {"label": "Version", "value": gameInfo["version"]},
          {"label": "Size", "value": gameInfo["size"]},
          {"label": "Age Rating", "value": gameInfo["minAge"]},
          {"label": "ESRB Rating", "value": gameInfo["esrbRating"]},
          {"label": "Release Date", "value": DateTime.parse(gameInfo["releaseDate"]).dMMMy},
          {"label": "Last Update", "value": DateTime.parse(gameInfo["lastUpdate"]).dMMMy},
        ]),
        
        _buildDetailSection("System Requirements", [
          {"label": "OS", "value": requirements["os"]},
          {"label": "Processor", "value": requirements["processor"]},
          {"label": "Memory", "value": requirements["memory"]},
          {"label": "Graphics", "value": requirements["graphics"]},
          {"label": "Storage", "value": requirements["storage"]},
        ]),
        
        _buildDetailSection("Publisher", [
          {"label": "Developer", "value": gameInfo["developer"]},
          {"label": "Publisher", "value": gameInfo["publisher"]},
        ]),
        
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Supported Languages",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (gameInfo["languages"] as List<String>).map((language) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spXs,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    language,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        
        if (gameInfo["inAppPurchases"] as bool) ...[
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: warningColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "This game contains in-app purchases",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: warningColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDetailSection(String title, List<Map<String, dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spXs),
        ...items.map((item) {
          return Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    "${item["label"]}:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "${item["value"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
