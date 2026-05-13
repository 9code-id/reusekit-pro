import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaTripMemoriesView extends StatefulWidget {
  const TtaTripMemoriesView({super.key});

  @override
  State<TtaTripMemoriesView> createState() => _TtaTripMemoriesViewState();
}

class _TtaTripMemoriesViewState extends State<TtaTripMemoriesView> {
  int selectedMemoryType = 0; // 0: All, 1: Photos, 2: Videos, 3: Notes
  String searchQuery = "";
  String selectedTrip = "All Trips";

  final List<Map<String, dynamic>> tripsList = [
    {"label": "All Trips", "value": "All Trips"},
    {"label": "Paris Weekend", "value": "Paris Weekend"},
    {"label": "Bali Adventure", "value": "Bali Adventure"},
    {"label": "Swiss Alps", "value": "Swiss Alps"},
    {"label": "Tokyo Cultural", "value": "Tokyo Cultural"},
  ];

  final List<Map<String, dynamic>> memories = [
    {
      "id": "1",
      "type": "photo",
      "title": "Eiffel Tower at Sunset",
      "trip": "Paris Weekend",
      "date": "2024-06-20",
      "location": "Paris, France",
      "url": "https://picsum.photos/300/400?random=1&keyword=eiffel",
      "description": "Beautiful golden hour view of the Eiffel Tower from Trocadéro",
      "tags": ["sunset", "tower", "romantic", "golden hour"],
      "likes": 45,
      "favorite": true,
      "coordinates": {"lat": 48.8584, "lng": 2.2945}
    },
    {
      "id": "2",
      "type": "video",
      "title": "Balinese Temple Dance",
      "trip": "Bali Adventure",
      "date": "2024-06-05",
      "location": "Ubud, Bali",
      "url": "https://picsum.photos/300/400?random=2&keyword=dance",
      "thumbnail": "https://picsum.photos/300/400?random=2&keyword=dance",
      "duration": "2:35",
      "description": "Traditional Kecak dance performance at Ubud temple",
      "tags": ["culture", "dance", "temple", "traditional"],
      "likes": 32,
      "favorite": false,
      "coordinates": {"lat": -8.5069, "lng": 115.2625}
    },
    {
      "id": "3",
      "type": "note",
      "title": "Best Croissant Ever",
      "trip": "Paris Weekend",
      "date": "2024-06-21",
      "location": "Montmartre, Paris",
      "description": "Found this amazing little bakery in Montmartre. The almond croissant was absolutely divine! Owner was so friendly and recommended the best spots in the neighborhood.",
      "tags": ["food", "bakery", "local", "recommendation"],
      "likes": 18,
      "favorite": true,
      "rating": 5.0
    },
    {
      "id": "4",
      "type": "photo",
      "title": "Alpine Lake Reflection",
      "trip": "Swiss Alps",
      "date": "2024-05-18",
      "location": "Lake Geneva, Switzerland",
      "url": "https://picsum.photos/300/400?random=3&keyword=lake",
      "description": "Perfect mirror reflection of the mountains in the crystal clear lake water",
      "tags": ["nature", "mountains", "reflection", "peaceful"],
      "likes": 67,
      "favorite": true,
      "coordinates": {"lat": 46.4312, "lng": 6.9040}
    },
    {
      "id": "5",
      "type": "video",
      "title": "Sushi Making Process",
      "trip": "Tokyo Cultural",
      "date": "2024-05-02",
      "location": "Tsukiji, Tokyo",
      "url": "https://picsum.photos/300/400?random=4&keyword=sushi",
      "thumbnail": "https://picsum.photos/300/400?random=4&keyword=sushi",
      "duration": "4:12",
      "description": "Master chef showing the art of making perfect sushi",
      "tags": ["food", "culture", "cooking", "masterclass"],
      "likes": 89,
      "favorite": false,
      "coordinates": {"lat": 35.6658, "lng": 139.7705}
    },
    {
      "id": "6",
      "type": "photo",
      "title": "Beach Sunset Silhouette",
      "trip": "Bali Adventure",
      "date": "2024-06-03",
      "location": "Uluwatu, Bali",
      "url": "https://picsum.photos/300/400?random=5&keyword=sunset",
      "description": "Dramatic silhouettes against the orange sky at Uluwatu cliff",
      "tags": ["sunset", "beach", "silhouette", "dramatic"],
      "likes": 53,
      "favorite": true,
      "coordinates": {"lat": -8.8290, "lng": 115.0844}
    },
    {
      "id": "7",
      "type": "note",
      "title": "Hiking Trail Discovery",
      "trip": "Swiss Alps",
      "date": "2024-05-17",
      "location": "Zermatt, Switzerland",
      "description": "Discovered this hidden trail that leads to an incredible viewpoint. 3-hour moderate hike but totally worth it. Pack warm clothes as it gets windy at the top!",
      "tags": ["hiking", "trail", "viewpoint", "adventure"],
      "likes": 24,
      "favorite": false,
      "rating": 4.5
    },
    {
      "id": "8",
      "type": "photo",
      "title": "Cherry Blossom Street",
      "trip": "Tokyo Cultural",
      "date": "2024-04-30",
      "location": "Shinjuku, Tokyo",
      "url": "https://picsum.photos/300/400?random=6&keyword=cherry",
      "description": "Perfect cherry blossom tunnel creating a pink canopy over the street",
      "tags": ["cherry blossom", "spring", "street", "pink"],
      "likes": 78,
      "favorite": true,
      "coordinates": {"lat": 35.6896, "lng": 139.6917}
    }
  ];

  List<Map<String, dynamic>> get filteredMemories {
    return memories.where((memory) {
      final matchesSearch = memory["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                           memory["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                           memory["location"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesTrip = selectedTrip == "All Trips" || memory["trip"] == selectedTrip;
      
      final matchesType = selectedMemoryType == 0 || // All
                         (selectedMemoryType == 1 && memory["type"] == "photo") ||
                         (selectedMemoryType == 2 && memory["type"] == "video") ||
                         (selectedMemoryType == 3 && memory["type"] == "note");
                         
      return matchesSearch && matchesTrip && matchesType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip Memories"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () {
              // Add new memory
            },
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              // View on map
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          _buildMemoryTypeSelector(),
          _buildStatsBar(),
          Expanded(
            child: _buildMemoriesGrid(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddMemoryOptions();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search memories...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {
                  _showFilterDialog();
                },
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          QDropdownField(
            label: "Filter by Trip",
            items: tripsList,
            value: selectedTrip,
            onChanged: (value, label) {
              selectedTrip = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMemoryTypeSelector() {
    final types = ["All", "Photos", "Videos", "Notes"];
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      child: Row(
        children: List.generate(types.length, (index) {
          final isSelected = selectedMemoryType == index;
          
          return Expanded(
            child: GestureDetector(
              onTap: () {
                selectedMemoryType = index;
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(right: index < types.length - 1 ? spXs : 0),
                padding: EdgeInsets.symmetric(vertical: spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                  ),
                ),
                child: Text(
                  types[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : disabledBoldColor,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStatsBar() {
    final filtered = filteredMemories;
    final totalPhotos = filtered.where((m) => m["type"] == "photo").length;
    final totalVideos = filtered.where((m) => m["type"] == "video").length;
    final totalNotes = filtered.where((m) => m["type"] == "note").length;
    final totalLikes = filtered.fold<int>(0, (sum, memory) => sum + (memory["likes"] as int));
    
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(51)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              icon: Icons.photo,
              count: totalPhotos,
              label: "Photos",
            ),
          ),
          Expanded(
            child: _buildStatItem(
              icon: Icons.videocam,
              count: totalVideos,
              label: "Videos",
            ),
          ),
          Expanded(
            child: _buildStatItem(
              icon: Icons.note,
              count: totalNotes,
              label: "Notes",
            ),
          ),
          Expanded(
            child: _buildStatItem(
              icon: Icons.favorite,
              count: totalLikes,
              label: "Likes",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required int count,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, color: primaryColor, size: 20),
        SizedBox(height: spXs),
        Text(
          "$count",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildMemoriesGrid() {
    final filtered = filteredMemories;
    
    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_library,
              size: 80,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No memories found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Start capturing your travel moments!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Add Memory",
              size: bs.md,
              onPressed: () {
                _showAddMemoryOptions();
              },
            ),
          ],
        ),
      );
    }
    
    return ResponsiveGridView(
      padding: EdgeInsets.all(spMd),
      minItemWidth: 160,
      children: filtered.map((memory) {
        return _buildMemoryCard(memory);
      }).toList(),
    );
  }

  Widget _buildMemoryCard(Map<String, dynamic> memory) {
    return GestureDetector(
      onTap: () {
        _showMemoryDetail(memory);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: disabledOutlineBorderColor),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMemoryCardHeader(memory),
            _buildMemoryCardContent(memory),
            _buildMemoryCardFooter(memory),
          ],
        ),
      ),
    );
  }

  Widget _buildMemoryCardHeader(Map<String, dynamic> memory) {
    if (memory["type"] == "note") {
      return Container(
        height: 120,
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(25),
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.note_alt,
                color: primaryColor,
                size: 40,
              ),
              SizedBox(height: spXs),
              Text(
                "Travel Note",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
      );
    }
    
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
          child: Image.network(
            memory["type"] == "video" ? "${memory["thumbnail"]}" : "${memory["url"]}",
            width: double.infinity,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        
        if (memory["type"] == "video")
          Positioned(
            top: spSm,
            left: spSm,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(128),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.play_arrow, color: Colors.white, size: 14),
                  SizedBox(width: spXs),
                  Text(
                    "${memory["duration"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
        Positioned(
          top: spSm,
          right: spSm,
          child: GestureDetector(
            onTap: () {
              memory["favorite"] = !memory["favorite"];
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(128),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                memory["favorite"] ? Icons.favorite : Icons.favorite_border,
                color: memory["favorite"] ? dangerColor : Colors.white,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMemoryCardContent(Map<String, dynamic> memory) {
    return Padding(
      padding: EdgeInsets.all(spSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${memory["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          SizedBox(height: spXs),
          
          Row(
            children: [
              Icon(Icons.location_on, color: disabledBoldColor, size: 12),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${memory["location"]}",
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
          
          Text(
            "${DateTime.parse(memory["date"]).dMMMy}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spXs),
          
          Text(
            "${memory["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildMemoryCardFooter(Map<String, dynamic> memory) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(25),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(radiusMd)),
      ),
      child: Row(
        children: [
          Icon(Icons.trip_origin, color: primaryColor, size: 14),
          SizedBox(width: spXs),
          Expanded(
            child: Text(
              "${memory["trip"]}",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              Icon(Icons.favorite, color: dangerColor, size: 14),
              SizedBox(width: spXs),
              Text(
                "${memory["likes"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showMemoryDetail(Map<String, dynamic> memory) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(maxHeight: 600),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${memory["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => back(),
                      ),
                    ],
                  ),
                ),
                
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (memory["type"] != "note") ...[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusMd),
                            child: Image.network(
                              memory["type"] == "video" ? "${memory["thumbnail"]}" : "${memory["url"]}",
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: spMd),
                        ],
                        
                        Text(
                          "${memory["description"]}",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                            height: 1.5,
                          ),
                        ),
                        
                        SizedBox(height: spMd),
                        
                        Row(
                          children: [
                            Icon(Icons.location_on, color: primaryColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${memory["location"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spXs),
                        
                        Row(
                          children: [
                            Icon(Icons.calendar_today, color: primaryColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${DateTime.parse(memory["date"]).dMMMy}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        
                        if (memory["tags"] != null) ...[
                          SizedBox(height: spMd),
                          Wrap(
                            spacing: spSm,
                            runSpacing: spXs,
                            children: (memory["tags"] as List).map((tag) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "#$tag",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddMemoryOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add New Memory",
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
                    child: QButton(
                      label: "Take Photo",
                      size: bs.md,
                      onPressed: () {
                        back();
                        // Open camera for photo
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Record Video",
                      size: bs.md,
                      onPressed: () {
                        back();
                        // Open camera for video
                      },
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spSm),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Write Note",
                  size: bs.md,
                  onPressed: () {
                    back();
                    // Navigate to note editor
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFilterDialog() {
    si("Advanced filters coming soon");
  }
}
