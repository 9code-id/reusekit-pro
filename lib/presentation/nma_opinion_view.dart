import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaOpinionView extends StatefulWidget {
  const NmaOpinionView({super.key});

  @override
  State<NmaOpinionView> createState() => _NmaOpinionViewState();
}

class _NmaOpinionViewState extends State<NmaOpinionView> {
  String selectedCategory = "All";
  String selectedTimeframe = "Today";
  String searchQuery = "";
  
  List<Map<String, dynamic>> opinions = [
    {
      "id": 1,
      "title": "The Future of Democracy in Digital Age",
      "author": "Dr. Sarah Johnson",
      "authorImage": "https://picsum.photos/100/100?random=1&keyword=woman",
      "category": "Politics",
      "readTime": 8,
      "publishedAt": "2024-01-16T10:30:00Z",
      "excerpt": "As technology reshapes our political landscape, we must examine how digital platforms influence democratic processes and voter behavior.",
      "image": "https://picsum.photos/400/200?random=1&keyword=democracy",
      "likes": 1245,
      "comments": 89,
      "shares": 156,
      "isLiked": false,
      "isBookmarked": true,
      "tags": ["Democracy", "Technology", "Politics"],
      "viewpoint": "Progressive",
      "controversial": false,
    },
    {
      "id": 2,
      "title": "Climate Change: Beyond the Political Rhetoric",
      "author": "Michael Chen",
      "authorImage": "https://picsum.photos/100/100?random=2&keyword=man",
      "category": "Environment",
      "readTime": 12,
      "publishedAt": "2024-01-16T08:15:00Z",
      "excerpt": "Moving past partisan debates to focus on practical solutions for environmental challenges facing our generation.",
      "image": "https://picsum.photos/400/200?random=2&keyword=climate",
      "likes": 2156,
      "comments": 234,
      "shares": 445,
      "isLiked": true,
      "isBookmarked": false,
      "tags": ["Climate", "Environment", "Policy"],
      "viewpoint": "Centrist",
      "controversial": true,
    },
    {
      "id": 3,
      "title": "The Economics of Remote Work Revolution",
      "author": "Emma Rodriguez",
      "authorImage": "https://picsum.photos/100/100?random=3&keyword=business",
      "category": "Business",
      "readTime": 6,
      "publishedAt": "2024-01-16T06:45:00Z",
      "excerpt": "How the shift to remote work is fundamentally changing labor markets, productivity metrics, and corporate culture worldwide.",
      "image": "https://picsum.photos/400/200?random=3&keyword=remote",
      "likes": 892,
      "comments": 67,
      "shares": 123,
      "isLiked": false,
      "isBookmarked": true,
      "tags": ["Remote Work", "Economy", "Future"],
      "viewpoint": "Conservative",
      "controversial": false,
    },
    {
      "id": 4,
      "title": "Social Media's Impact on Mental Health",
      "author": "Dr. Lisa Anderson",
      "authorImage": "https://picsum.photos/100/100?random=4&keyword=doctor",
      "category": "Health",
      "readTime": 10,
      "publishedAt": "2024-01-15T16:20:00Z",
      "excerpt": "Examining the complex relationship between digital connectivity and psychological wellbeing in the modern era.",
      "image": "https://picsum.photos/400/200?random=4&keyword=mental",
      "likes": 1678,
      "comments": 312,
      "shares": 289,
      "isLiked": true,
      "isBookmarked": false,
      "tags": ["Mental Health", "Social Media", "Psychology"],
      "viewpoint": "Progressive",
      "controversial": true,
    },
    {
      "id": 5,
      "title": "The Changing Face of Modern Education",
      "author": "Robert Kim",
      "authorImage": "https://picsum.photos/100/100?random=5&keyword=teacher",
      "category": "Education",
      "readTime": 7,
      "publishedAt": "2024-01-15T14:10:00Z",
      "excerpt": "Traditional classroom models are being challenged by innovative teaching methods and technological integration.",
      "image": "https://picsum.photos/400/200?random=5&keyword=education",
      "likes": 743,
      "comments": 45,
      "shares": 87,
      "isLiked": false,
      "isBookmarked": true,
      "tags": ["Education", "Innovation", "Technology"],
      "viewpoint": "Centrist",
      "controversial": false,
    },
  ];

  List<String> categories = ["All", "Politics", "Environment", "Business", "Health", "Education", "Technology"];
  List<String> timeframes = ["Today", "This Week", "This Month", "All Time"];
  List<String> viewpoints = ["All", "Progressive", "Conservative", "Centrist"];
  
  String selectedViewpoint = "All";

  List<Map<String, dynamic>> get filteredOpinions {
    return opinions.where((opinion) {
      bool matchesSearch = "${opinion["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${opinion["excerpt"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || "${opinion["category"]}" == selectedCategory;
      bool matchesViewpoint = selectedViewpoint == "All" || "${opinion["viewpoint"]}" == selectedViewpoint;
      
      // Simple timeframe filter
      bool matchesTimeframe = true;
      if (selectedTimeframe != "All Time") {
        DateTime publishedDate = DateTime.parse(opinion["publishedAt"] as String);
        DateTime now = DateTime.now();
        switch (selectedTimeframe) {
          case "Today":
            matchesTimeframe = publishedDate.day == now.day;
            break;
          case "This Week":
            matchesTimeframe = now.difference(publishedDate).inDays <= 7;
            break;
          case "This Month":
            matchesTimeframe = now.difference(publishedDate).inDays <= 30;
            break;
        }
      }
      
      return matchesSearch && matchesCategory && matchesViewpoint && matchesTimeframe;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Opinion & Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search opinions",
                    value: searchQuery,
                    hint: "Search by title or content",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.tune,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Filter Row
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories.map((cat) => {"label": cat, "value": cat}).toList(),
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
                    label: "Viewpoint",
                    items: viewpoints.map((vp) => {"label": vp, "value": vp}).toList(),
                    value: selectedViewpoint,
                    onChanged: (value, label) {
                      selectedViewpoint = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Timeframe Filter
            QCategoryPicker(
              items: timeframes.map((timeframe) => {
                "label": timeframe,
                "value": timeframe,
              }).toList(),
              value: selectedTimeframe,
              onChanged: (index, label, value, item) {
                selectedTimeframe = value;
                setState(() {});
              },
            ),

            // Stats Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredOpinions.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Articles",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: disabledOutlineBorderColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredOpinions.where((op) => op["controversial"] as bool).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Controversial",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: disabledOutlineBorderColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${(filteredOpinions.fold(0, (sum, op) => sum + (op["readTime"] as int)) / filteredOpinions.length).toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Avg. Read Time",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Opinion Articles List
            ...filteredOpinions.map((opinion) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    // Header Image
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${opinion["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Controversial Badge
                          if (opinion["controversial"] as bool)
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "CONTROVERSIAL",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          // Bookmark Button
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: GestureDetector(
                              onTap: () {
                                opinion["isBookmarked"] = !(opinion["isBookmarked"] as bool);
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(200),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  (opinion["isBookmarked"] as bool) ? Icons.bookmark : Icons.bookmark_border,
                                  color: primaryColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Article Info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        // Category and Viewpoint
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${opinion["category"]}",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: secondaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${opinion["viewpoint"]}",
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${opinion["readTime"]} min read",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                        // Title
                        Text(
                          "${opinion["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                            height: 1.3,
                          ),
                        ),

                        // Excerpt
                        Text(
                          "${opinion["excerpt"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),

                        // Tags
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (opinion["tags"] as List).map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "#$tag",
                                style: TextStyle(
                                  color: infoColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        // Author Info
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusMd),
                                image: DecorationImage(
                                  image: NetworkImage("${opinion["authorImage"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${opinion["author"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "${DateTime.parse(opinion["publishedAt"] as String).dMMMy}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Engagement Stats
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                opinion["isLiked"] = !(opinion["isLiked"] as bool);
                                if (opinion["isLiked"] as bool) {
                                  opinion["likes"] = (opinion["likes"] as int) + 1;
                                } else {
                                  opinion["likes"] = (opinion["likes"] as int) - 1;
                                }
                                setState(() {});
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    (opinion["isLiked"] as bool) ? Icons.favorite : Icons.favorite_border,
                                    color: (opinion["isLiked"] as bool) ? dangerColor : disabledBoldColor,
                                    size: 18,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${opinion["likes"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spMd),
                            Row(
                              children: [
                                Icon(
                                  Icons.comment_outlined,
                                  color: disabledBoldColor,
                                  size: 18,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${opinion["comments"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: spMd),
                            Row(
                              children: [
                                Icon(
                                  Icons.share_outlined,
                                  color: disabledBoldColor,
                                  size: 18,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${opinion["shares"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            QButton(
                              label: "Read Article",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            if (filteredOpinions.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  spacing: spMd,
                  children: [
                    Icon(
                      Icons.article_outlined,
                      size: 60,
                      color: disabledBoldColor,
                    ),
                    Text(
                      "No opinion articles found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your filters or search terms",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
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
}
