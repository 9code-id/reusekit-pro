import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsBarberGalleryView extends StatefulWidget {
  const BrsBarberGalleryView({super.key});

  @override
  State<BrsBarberGalleryView> createState() => _BrsBarberGalleryViewState();
}

class _BrsBarberGalleryViewState extends State<BrsBarberGalleryView> {
  int selectedCategory = 0;
  bool isGridView = true;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "all"},
    {"label": "Haircuts", "value": "haircuts"},
    {"label": "Beard", "value": "beard"},
    {"label": "Styling", "value": "styling"},
    {"label": "Coloring", "value": "coloring"},
  ];

  List<Map<String, dynamic>> galleryItems = [
    {
      "id": 1,
      "image": "https://picsum.photos/300/400?random=1&keyword=haircut",
      "title": "Classic Fade",
      "category": "haircuts",
      "likes": 24,
      "comments": 8,
      "date": "2024-01-15",
      "description": "Professional classic fade with perfect blend"
    },
    {
      "id": 2,
      "image": "https://picsum.photos/300/400?random=2&keyword=beard",
      "title": "Beard Trim",
      "category": "beard",
      "likes": 18,
      "comments": 5,
      "date": "2024-01-14",
      "description": "Precision beard trimming and shaping"
    },
    {
      "id": 3,
      "image": "https://picsum.photos/300/400?random=3&keyword=hairstyle",
      "title": "Modern Pompadour",
      "category": "styling",
      "likes": 32,
      "comments": 12,
      "date": "2024-01-13",
      "description": "Stylish pompadour with volume and texture"
    },
    {
      "id": 4,
      "image": "https://picsum.photos/300/400?random=4&keyword=haircolor",
      "title": "Color Highlights",
      "category": "coloring",
      "likes": 28,
      "comments": 9,
      "date": "2024-01-12",
      "description": "Natural color highlights and balayage"
    },
    {
      "id": 5,
      "image": "https://picsum.photos/300/400?random=5&keyword=haircut",
      "title": "Undercut Style",
      "category": "haircuts",
      "likes": 22,
      "comments": 6,
      "date": "2024-01-11",
      "description": "Sharp undercut with textured top"
    },
    {
      "id": 6,
      "image": "https://picsum.photos/300/400?random=6&keyword=beard",
      "title": "Full Beard",
      "category": "beard",
      "likes": 19,
      "comments": 4,
      "date": "2024-01-10",
      "description": "Full beard styling and maintenance"
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    if (selectedCategory == 0) return galleryItems;
    String categoryValue = categories[selectedCategory]["value"];
    return galleryItems.where((item) => item["category"] == categoryValue).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            height: 50,
            child: QHorizontalScroll(
              children: List.generate(categories.length, (index) {
                final category = categories[index];
                final isSelected = selectedCategory == index;
                return GestureDetector(
                  onTap: () {
                    selectedCategory = index;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: index == 0 ? spMd : spXs,
                      right: index == categories.length - 1 ? spMd : spXs,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Text(
                      "${category["label"]}",
                      style: TextStyle(
                        color: isSelected ? Colors.white : disabledBoldColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Gallery Grid/List
          Expanded(
            child: isGridView ? _buildGridView() : _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return ResponsiveGridView(
      padding: EdgeInsets.all(spMd),
      minItemWidth: 200,
      children: filteredItems.map((item) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: AspectRatio(
                  aspectRatio: 3/4,
                  child: Image.network(
                    "${item["image"]}",
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              
              Padding(
                padding: EdgeInsets.all(spSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    SizedBox(height: spXs),
                    
                    Text(
                      "${item["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    SizedBox(height: spXs),
                    
                    Row(
                      children: [
                        Icon(Icons.favorite, size: 16, color: dangerColor),
                        SizedBox(width: spXs),
                        Text(
                          "${item["likes"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        
                        SizedBox(width: spSm),
                        
                        Icon(Icons.comment, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${item["comments"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        
                        Spacer(),
                        
                        Text(
                          "${DateTime.parse(item["date"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${item["image"]}",
                  width: 80,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              
              SizedBox(width: spSm),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    SizedBox(height: spXs),
                    
                    Text(
                      "${item["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    SizedBox(height: spXs),
                    
                    Row(
                      children: [
                        Icon(Icons.favorite, size: 16, color: dangerColor),
                        SizedBox(width: spXs),
                        Text(
                          "${item["likes"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        
                        SizedBox(width: spSm),
                        
                        Icon(Icons.comment, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${item["comments"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        
                        Spacer(),
                        
                        Text(
                          "${DateTime.parse(item["date"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
