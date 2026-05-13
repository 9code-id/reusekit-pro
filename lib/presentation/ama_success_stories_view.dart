import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaSuccessStoriesView extends StatefulWidget {
  const AmaSuccessStoriesView({super.key});

  @override
  State<AmaSuccessStoriesView> createState() => _AmaSuccessStoriesViewState();
}

class _AmaSuccessStoriesViewState extends State<AmaSuccessStoriesView> {
  int selectedFilter = 0;
  String searchQuery = "";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Stories", "value": 0},
    {"label": "Crop Yield", "value": 1},
    {"label": "Sustainability", "value": 2},
    {"label": "Technology", "value": 3},
    {"label": "Community", "value": 4},
  ];
  
  List<Map<String, dynamic>> successStories = [
    {
      "id": "1",
      "title": "From 2 Acres to 500: A Journey of Growth",
      "farmer": "Maria Santos",
      "location": "São Paulo, Brazil",
      "category": "Crop Yield",
      "achievement": "Increased yield by 400% in 5 years",
      "story": "Maria started with just 2 acres of land and traditional farming methods. Through precision agriculture and community support, she now manages 500 acres with sustainable practices.",
      "image": "https://picsum.photos/400/250?random=1&keyword=farm",
      "farmerImage": "https://picsum.photos/60/60?random=11&keyword=farmer",
      "beforeValue": 2000,
      "afterValue": 10000,
      "timeframe": "5 years",
      "likes": 1247,
      "shares": 89,
      "comments": 156,
      "publishedDate": "2024-06-10",
      "tags": ["precision-agriculture", "growth", "success"],
    },
    {
      "id": "2",
      "title": "Zero Waste Farm: Complete Sustainability",
      "farmer": "David Kim", 
      "location": "California, USA",
      "category": "Sustainability",
      "achievement": "Achieved 100% waste recycling",
      "story": "David transformed his conventional farm into a zero-waste operation, using every organic material and implementing renewable energy sources throughout his 200-acre property.",
      "image": "https://picsum.photos/400/250?random=2&keyword=sustainable",
      "farmerImage": "https://picsum.photos/60/60?random=12&keyword=farmer",
      "beforeValue": 20,
      "afterValue": 100,
      "timeframe": "3 years",
      "likes": 2341,
      "shares": 234,
      "comments": 89,
      "publishedDate": "2024-06-08",
      "tags": ["zero-waste", "renewable", "organic"],
    },
    {
      "id": "3",
      "title": "AI Revolutionizes Small Farm Operations",
      "farmer": "Priya Sharma",
      "location": "Punjab, India", 
      "category": "Technology",
      "achievement": "Reduced costs by 60% using AI",
      "story": "Priya integrated AI-powered crop monitoring and automated irrigation systems, dramatically reducing operational costs while increasing crop quality and yield on her family farm.",
      "image": "https://picsum.photos/400/250?random=3&keyword=technology",
      "farmerImage": "https://picsum.photos/60/60?random=13&keyword=farmer",
      "beforeValue": 40,
      "afterValue": 85,
      "timeframe": "2 years",
      "likes": 1876,
      "shares": 167,
      "comments": 234,
      "publishedDate": "2024-06-05",
      "tags": ["AI", "automation", "efficiency"],
    },
    {
      "id": "4",
      "title": "Building a Farming Cooperative Network",
      "farmer": "Ahmed Hassan",
      "location": "Morocco",
      "category": "Community",
      "achievement": "United 150 small farmers",
      "story": "Ahmed organized local farmers into a cooperative, sharing resources, knowledge, and market access. The network now serves 150 families and has increased everyone's income by 200%.",
      "image": "https://picsum.photos/400/250?random=4&keyword=community",
      "farmerImage": "https://picsum.photos/60/60?random=14&keyword=farmer",
      "beforeValue": 15,
      "afterValue": 150,
      "timeframe": "4 years",
      "likes": 3245,
      "shares": 456,
      "comments": 178,
      "publishedDate": "2024-06-03",
      "tags": ["cooperative", "community", "network"],
    },
    {
      "id": "5",
      "title": "Organic Certification Success Story",
      "farmer": "Emma Thompson",
      "location": "New Zealand",
      "category": "Sustainability", 
      "achievement": "Premium prices with organic certification",
      "story": "Emma transitioned to organic farming and achieved international certification, allowing her to sell produce at premium prices while maintaining environmental sustainability.",
      "image": "https://picsum.photos/400/250?random=5&keyword=organic",
      "farmerImage": "https://picsum.photos/60/60?random=15&keyword=farmer",
      "beforeValue": 30,
      "afterValue": 95,
      "timeframe": "3 years",
      "likes": 1654,
      "shares": 123,
      "comments": 67,
      "publishedDate": "2024-06-01",
      "tags": ["organic", "certification", "premium"],
    },
  ];

  List<Map<String, dynamic>> get filteredStories {
    List<Map<String, dynamic>> filtered = List.from(successStories);
    
    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((story) =>
        (story["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (story["farmer"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (story["story"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    // Apply category filter
    if (selectedFilter > 0) {
      String categoryName = filterOptions[selectedFilter]["label"] as String;
      filtered = filtered.where((story) => 
        story["category"] as String == categoryName
      ).toList();
    }
    
    return filtered;
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Crop Yield":
        return successColor;
      case "Sustainability":
        return primaryColor;
      case "Technology":
        return infoColor;
      case "Community":
        return warningColor;
      default:
        return secondaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Success Stories"),
        actions: [
          QButton(
            icon: Icons.add_circle,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
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
                    label: "Search success stories...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.favorite,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
            
            // Filter Categories
            QCategoryPicker(
              items: filterOptions,
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value as int;
                setState(() {});
              },
            ),
            
            // Inspiration Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, primaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.emoji_events,
                    size: 48,
                    color: Colors.white,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Inspiring Agricultural Success",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Real stories from farmers who transformed their operations",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "1,247",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Success Stories",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "89%",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Success Rate",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Success Stories
            ...List.generate(filteredStories.length, (index) {
              final story = filteredStories[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Story Image
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                      child: Stack(
                        children: [
                          Image.network(
                            "${story["image"]}",
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getCategoryColor(story["category"] as String),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${story["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Story Content
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          // Title
                          Text(
                            "${story["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          
                          // Farmer Info
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusLg),
                                child: Image.network(
                                  "${story["farmerImage"]}",
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${story["farmer"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: secondaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${story["location"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${story["timeframe"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600, 
                                    color: successColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          // Achievement Highlight
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: warningColor.withAlpha(30)),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.emoji_events,
                                  size: 20,
                                  color: warningColor,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${story["achievement"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: warningColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Story Summary
                          Text(
                            "${story["story"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                          ),
                          
                          // Before/After Stats
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Before",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${story["beforeValue"]}%",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: dangerColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: primaryColor,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "After",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${story["afterValue"]}%",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Engagement Stats
                          Row(
                            children: [
                              Icon(
                                Icons.favorite,
                                size: 16,
                                color: dangerColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${story["likes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.share,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${story["shares"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.comment,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${story["comments"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              QButton(
                                label: "Read Full Story",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            
            if (filteredStories.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No success stories found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try different search terms or categories",
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
      ),
    );
  }
}
