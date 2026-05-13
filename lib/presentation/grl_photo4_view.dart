import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPhoto4View extends StatefulWidget {
  @override
  State<GrlPhoto4View> createState() => _GrlPhoto4ViewState();
}

class _GrlPhoto4ViewState extends State<GrlPhoto4View> {
  List<Map<String, dynamic>> photos = [
    {
      "id": "1",
      "url": "https://picsum.photos/400/600?random=1&keyword=nature",
      "title": "Mountain Sunrise",
      "location": "Rocky Mountains",
      "photographer": "Alex Johnson",
      "likes": 245,
      "isLiked": false,
      "category": "Nature",
      "date": "2024-12-15",
    },
    {
      "id": "2", 
      "url": "https://picsum.photos/400/500?random=2&keyword=city",
      "title": "Urban Nights",
      "location": "New York City",
      "photographer": "Sarah Chen",
      "likes": 189,
      "isLiked": true,
      "category": "Urban",
      "date": "2024-12-14",
    },
    {
      "id": "3",
      "url": "https://picsum.photos/400/650?random=3&keyword=ocean",
      "title": "Ocean Waves",
      "location": "Malibu Beach",
      "photographer": "Mike Wilson",
      "likes": 312,
      "isLiked": false,
      "category": "Nature",
      "date": "2024-12-13",
    },
    {
      "id": "4",
      "url": "https://picsum.photos/400/550?random=4&keyword=forest",
      "title": "Forest Path",
      "location": "Amazon Rainforest",
      "photographer": "Emma Davis",
      "likes": 198,
      "isLiked": true,
      "category": "Nature",
      "date": "2024-12-12",
    },
    {
      "id": "5",
      "url": "https://picsum.photos/400/600?random=5&keyword=architecture",
      "title": "Modern Architecture",
      "location": "Tokyo, Japan",
      "photographer": "Yuki Tanaka",
      "likes": 276,
      "isLiked": false,
      "category": "Architecture",
      "date": "2024-12-11",
    },
    {
      "id": "6",
      "url": "https://picsum.photos/400/580?random=6&keyword=sunset",
      "title": "Desert Sunset",
      "location": "Sahara Desert",
      "photographer": "Omar Hassan",
      "likes": 423,
      "isLiked": true,
      "category": "Nature",
      "date": "2024-12-10",
    },
  ];

  String selectedCategory = "All";
  List<String> categories = ["All", "Nature", "Urban", "Architecture"];

  void _toggleLike(int index) {
    setState(() {
      photos[index]["isLiked"] = !photos[index]["isLiked"];
      if (photos[index]["isLiked"]) {
        photos[index]["likes"] = (photos[index]["likes"] as int) + 1;
      } else {
        photos[index]["likes"] = (photos[index]["likes"] as int) - 1;
      }
    });
  }

  List<Map<String, dynamic>> get filteredPhotos {
    if (selectedCategory == "All") return photos;
    return photos.where((photo) => photo["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Gallery"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Filter
            QCategoryPicker(
              label: "Category",
              items: categories.map((category) => {
                "label": category,
                "value": category,
              }).toList(),
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Stats Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredPhotos.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Photos",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${photos.fold(0, (sum, photo) => sum + (photo["likes"] as int))}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
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
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${photos.where((photo) => photo["isLiked"]).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Favorites",
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
            
            SizedBox(height: spLg),
            
            // Photo Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredPhotos.map((photo) {
                int index = photos.indexOf(photo);
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Photo Image
                      Stack(
                        children: [
                          Container(
                            height: 180,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                              child: Image.network(
                                "${photo["url"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: spXs,
                            right: spXs,
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: GestureDetector(
                                onTap: () => _toggleLike(index),
                                child: Icon(
                                  (photo["isLiked"] as bool) ? Icons.favorite : Icons.favorite_border,
                                  color: (photo["isLiked"] as bool) ? dangerColor : Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: spXs,
                            left: spXs,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${photo["category"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      // Photo Info
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${photo["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    "${photo["location"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    "${photo["photographer"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Icon(
                                  Icons.favorite,
                                  size: 12,
                                  color: dangerColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${photo["likes"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_a_photo),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }
}
