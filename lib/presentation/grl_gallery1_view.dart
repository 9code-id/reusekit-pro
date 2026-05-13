import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlGallery1View extends StatefulWidget {
  @override
  State<GrlGallery1View> createState() => _GrlGallery1ViewState();
}

class _GrlGallery1ViewState extends State<GrlGallery1View> {
  String selectedCategory = "All";
  bool loading = false;

  final List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Nature", "value": "Nature"},
    {"label": "Architecture", "value": "Architecture"},
    {"label": "People", "value": "People"},
    {"label": "Food", "value": "Food"},
  ];

  final List<Map<String, dynamic>> images = [
    {
      "id": 1,
      "title": "Mountain Landscape",
      "category": "Nature",
      "url": "https://picsum.photos/400/600?random=1&keyword=mountain",
      "photographer": "John Doe",
      "likes": 142,
      "date": "2024-01-15"
    },
    {
      "id": 2,
      "title": "Modern Architecture",
      "category": "Architecture",
      "url": "https://picsum.photos/400/500?random=2&keyword=building",
      "photographer": "Jane Smith",
      "likes": 89,
      "date": "2024-01-14"
    },
    {
      "id": 3,
      "title": "Street Portrait",
      "category": "People",
      "url": "https://picsum.photos/400/700?random=3&keyword=people",
      "photographer": "Mike Johnson",
      "likes": 256,
      "date": "2024-01-13"
    },
    {
      "id": 4,
      "title": "Delicious Meal",
      "category": "Food",
      "url": "https://picsum.photos/400/400?random=4&keyword=food",
      "photographer": "Sarah Wilson",
      "likes": 178,
      "date": "2024-01-12"
    },
    {
      "id": 5,
      "title": "Ocean Waves",
      "category": "Nature",
      "url": "https://picsum.photos/400/550?random=5&keyword=ocean",
      "photographer": "David Brown",
      "likes": 203,
      "date": "2024-01-11"
    },
    {
      "id": 6,
      "title": "City Skyline",
      "category": "Architecture",
      "url": "https://picsum.photos/400/650?random=6&keyword=city",
      "photographer": "Emma Davis",
      "likes": 134,
      "date": "2024-01-10"
    },
  ];

  List<Map<String, dynamic>> get filteredImages {
    if (selectedCategory == "All") return images;
    return images.where((img) => img["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Gallery"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // navigateTo(SearchView());
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              // navigateTo(FavoritesView());
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Discover Amazing Photos",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Explore curated collection of stunning photography",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.photo_library,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                    ],
                  ),

                  // Category Filter
                  QCategoryPicker(
                    label: "Filter by Category",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (index, label, value, item) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),

                  // Stats Section
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${images.length}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Photos",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: disabledColor,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${(images.map((img) => img["likes"] as int).reduce((a, b) => a + b))}", 
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Likes",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: disabledColor,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${categories.length - 1}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Categories",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Photo Grid
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: filteredImages.map((image) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Stack(
                            children: [
                              // Image
                              Image.network(
                                "${image["url"]}",
                                width: double.infinity,
                                height: 250,
                                fit: BoxFit.cover,
                              ),

                              // Gradient Overlay
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withAlpha(180),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // Image Info
                              Positioned(
                                bottom: spSm,
                                left: spSm,
                                right: spSm,
                                child: Column(
                                  spacing: spXs,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${image["title"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          size: 14,
                                          color: Colors.white70,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${image["photographer"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.favorite,
                                          size: 14,
                                          color: dangerColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${image["likes"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // Like Button
                              Positioned(
                                top: spSm,
                                right: spSm,
                                child: GestureDetector(
                                  onTap: () {
                                    ss("Added to favorites!");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withAlpha(200),
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                    child: Icon(
                                      Icons.favorite_border,
                                      size: 20,
                                      color: dangerColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  // Load More Button
                  Center(
                    child: QButton(
                      label: "Load More Photos",
                      size: bs.md,
                      onPressed: () async {
                        loading = true;
                        setState(() {});
                        
                        await Future.delayed(Duration(seconds: 2));
                        
                        loading = false;
                        setState(() {});
                        
                        si("More photos loaded!");
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
