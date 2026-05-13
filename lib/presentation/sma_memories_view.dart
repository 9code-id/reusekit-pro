import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaMemoriesView extends StatefulWidget {
  const SmaMemoriesView({super.key});

  @override
  State<SmaMemoriesView> createState() => _SmaMemoriesViewState();
}

class _SmaMemoriesViewState extends State<SmaMemoriesView> {
  String selectedFilter = "all";
  String searchQuery = "";
  bool isGridView = true;
  
  List<Map<String, dynamic>> memories = [
    {
      "id": 1,
      "title": "Weekend Adventure",
      "description": "Amazing hiking trip with friends in the mountains",
      "date": "2024-06-15",
      "photoCount": 12,
      "coverImage": "https://picsum.photos/300/200?random=1&keyword=mountain",
      "photos": [
        "https://picsum.photos/300/300?random=1&keyword=mountain",
        "https://picsum.photos/300/300?random=2&keyword=hiking",
        "https://picsum.photos/300/300?random=3&keyword=nature",
      ],
      "location": "Rocky Mountains",
      "tags": ["hiking", "friends", "nature", "adventure"],
      "type": "auto",
    },
    {
      "id": 2,
      "title": "Family Dinner",
      "description": "Special family gathering for mom's birthday celebration",
      "date": "2024-06-10",
      "photoCount": 8,
      "coverImage": "https://picsum.photos/300/200?random=4&keyword=family",
      "photos": [
        "https://picsum.photos/300/300?random=4&keyword=family",
        "https://picsum.photos/300/300?random=5&keyword=dinner",
        "https://picsum.photos/300/300?random=6&keyword=birthday",
      ],
      "location": "Home",
      "tags": ["family", "birthday", "celebration", "home"],
      "type": "manual",
    },
    {
      "id": 3,
      "title": "Beach Vacation",
      "description": "Relaxing week at the beautiful seaside resort",
      "date": "2024-06-01",
      "photoCount": 25,
      "coverImage": "https://picsum.photos/300/200?random=7&keyword=beach",
      "photos": [
        "https://picsum.photos/300/300?random=7&keyword=beach",
        "https://picsum.photos/300/300?random=8&keyword=ocean",
        "https://picsum.photos/300/300?random=9&keyword=sunset",
      ],
      "location": "Malibu Beach",
      "tags": ["beach", "vacation", "sunset", "ocean"],
      "type": "auto",
    },
    {
      "id": 4,
      "title": "Office Team Building",
      "description": "Fun day with colleagues at the adventure park",
      "date": "2024-05-28",
      "photoCount": 15,
      "coverImage": "https://picsum.photos/300/200?random=10&keyword=team",
      "photos": [
        "https://picsum.photos/300/300?random=10&keyword=team",
        "https://picsum.photos/300/300?random=11&keyword=office",
        "https://picsum.photos/300/300?random=12&keyword=group",
      ],
      "location": "Adventure Park",
      "tags": ["work", "team", "colleagues", "fun"],
      "type": "manual",
    },
    {
      "id": 5,
      "title": "City Exploration",
      "description": "Walking tour of downtown and discovering new cafes",
      "date": "2024-05-20",
      "photoCount": 18,
      "coverImage": "https://picsum.photos/300/200?random=13&keyword=city",
      "photos": [
        "https://picsum.photos/300/300?random=13&keyword=city",
        "https://picsum.photos/300/300?random=14&keyword=street",
        "https://picsum.photos/300/300?random=15&keyword=cafe",
      ],
      "location": "Downtown",
      "tags": ["city", "exploration", "cafe", "walking"],
      "type": "auto",
    },
    {
      "id": 6,
      "title": "Pet Day Out",
      "description": "Fun day at the dog park with Max and friends",
      "date": "2024-05-15",
      "photoCount": 9,
      "coverImage": "https://picsum.photos/300/200?random=16&keyword=dog",
      "photos": [
        "https://picsum.photos/300/300?random=16&keyword=dog",
        "https://picsum.photos/300/300?random=17&keyword=pet",
        "https://picsum.photos/300/300?random=18&keyword=park",
      ],
      "location": "Central Dog Park",
      "tags": ["pet", "dog", "park", "friends"],
      "type": "manual",
    },
  ];

  List<Map<String, dynamic>> get filteredMemories {
    var filtered = memories.where((memory) {
      if (searchQuery.isNotEmpty) {
        return "${memory["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               "${memory["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               (memory["tags"] as List).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()));
      }
      return true;
    }).toList();

    if (selectedFilter != "all") {
      filtered = filtered.where((memory) => memory["type"] == selectedFilter).toList();
    }

    // Sort by date (newest first)
    filtered.sort((a, b) => DateTime.parse("${b["date"]}").compareTo(DateTime.parse("${a["date"]}")));

    return filtered;
  }

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Memories", "value": "all"},
    {"label": "Auto Created", "value": "auto"},
    {"label": "Manual Created", "value": "manual"},
  ];

  void _createNewMemory() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Create New Memory",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => back(),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    QTextField(
                      label: "Memory Title",
                      value: "",
                      hint: "Enter a title for your memory",
                      onChanged: (value) {},
                    ),
                    SizedBox(height: spMd),
                    QMemoField(
                      label: "Description",
                      value: "",
                      hint: "Describe what makes this memory special",
                      onChanged: (value) {},
                    ),
                    SizedBox(height: spMd),
                    QDatePicker(
                      label: "Memory Date",
                      value: DateTime.now(),
                      onChanged: (value) {},
                    ),
                    SizedBox(height: spMd),
                    QTextField(
                      label: "Location",
                      value: "",
                      hint: "Where did this happen?",
                      onChanged: (value) {},
                    ),
                    SizedBox(height: spMd),
                    QMultiImagePicker(
                      label: "Select Photos",
                      value: [],
                      maxImages: 20,
                      hint: "Choose photos for this memory",
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Create Memory",
                onPressed: () {
                  back();
                  ss("Memory created successfully");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _viewMemoryDetails(Map<String, dynamic> memory) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${memory["title"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              DateTime.parse("${memory["date"]}").dMMMy,
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Icon(Icons.photo, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${memory["photoCount"]} photos",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
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
                    // Cover Image
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusMd),
                        image: DecorationImage(
                          image: NetworkImage("${memory["coverImage"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Description
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${memory["description"]}",
                      style: TextStyle(fontSize: 16),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Location
                    if (memory["location"] != null) ...[
                      Row(
                        children: [
                          Icon(Icons.location_on, color: primaryColor),
                          SizedBox(width: spSm),
                          Text(
                            "${memory["location"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                    ],
                    
                    // Tags
                    Text(
                      "Tags",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spSm,
                      runSpacing: spSm,
                      children: (memory["tags"] as List).map((tag) => Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "#$tag",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )).toList(),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Photos Grid
                    Text(
                      "Photos",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 150,
                      children: (memory["photos"] as List).map((photo) => Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusSm),
                          image: DecorationImage(
                            image: NetworkImage("$photo"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ),
            
            // Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Share Memory",
                      color: primaryColor,
                      onPressed: () {
                        back();
                        ss("Memory shared successfully");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.edit,
                    size: bs.sm,
                    color: disabledBoldColor,
                    onPressed: () {
                      back();
                      si("Opening memory editor");
                    },
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.delete,
                    size: bs.sm,
                    color: dangerColor,
                    onPressed: () async {
                      back();
                      bool isConfirmed = await confirm("Delete this memory? This action cannot be undone.");
                      if (isConfirmed) {
                        setState(() {
                          memories.removeWhere((m) => m["id"] == memory["id"]);
                        });
                        ss("Memory deleted");
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Memories"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _createNewMemory,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
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
                      icon: Icons.search,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Filter",
                        items: filterOptions,
                        value: selectedFilter,
                        onChanged: (value, label) {
                          selectedFilter = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Memories Content
          Expanded(
            child: filteredMemories.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.photo_library,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          searchQuery.isNotEmpty ? "No Memories Found" : "No Memories Yet",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          searchQuery.isNotEmpty
                              ? "Try adjusting your search or filters"
                              : "Create your first memory to get started",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                        if (searchQuery.isEmpty) ...[
                          SizedBox(height: spMd),
                          QButton(
                            label: "Create Memory",
                            onPressed: _createNewMemory,
                          ),
                        ],
                      ],
                    ),
                  )
                : isGridView
                    ? ResponsiveGridView(
                        padding: EdgeInsets.all(spMd),
                        minItemWidth: 200,
                        children: filteredMemories.map((memory) => Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(radiusMd),
                              onTap: () => _viewMemoryDetails(memory),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Cover Image
                                  Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                                      image: DecorationImage(
                                        image: NetworkImage("${memory["coverImage"]}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: spSm,
                                          right: spSm,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: Colors.black.withAlpha(128),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${memory["photoCount"]}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  // Content
                                  Padding(
                                    padding: EdgeInsets.all(spMd),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${memory["title"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          "${memory["description"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: spSm),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today,
                                              size: 12,
                                              color: disabledColor,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              DateTime.parse("${memory["date"]}").dMMMy,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledColor,
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                                              decoration: BoxDecoration(
                                                color: memory["type"] == "auto" ? Colors.blue.withAlpha(20) : Colors.green.withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXxs),
                                              ),
                                              child: Text(
                                                "${memory["type"]}".toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w600,
                                                  color: memory["type"] == "auto" ? Colors.blue : Colors.green,
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
                            ),
                          ),
                        )).toList(),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(spMd),
                        itemCount: filteredMemories.length,
                        itemBuilder: (context, index) {
                          final memory = filteredMemories[index];
                          
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              boxShadow: [shadowSm],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(radiusMd),
                                onTap: () => _viewMemoryDetails(memory),
                                child: Padding(
                                  padding: EdgeInsets.all(spMd),
                                  child: Row(
                                    children: [
                                      // Cover Image
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(radiusSm),
                                          image: DecorationImage(
                                            image: NetworkImage("${memory["coverImage"]}"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              bottom: 4,
                                              right: 4,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: Colors.black.withAlpha(128),
                                                  borderRadius: BorderRadius.circular(radiusXxs),
                                                ),
                                                child: Text(
                                                  "${memory["photoCount"]}",
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
                                      ),
                                      
                                      SizedBox(width: spMd),
                                      
                                      // Content
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "${memory["title"]}",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                                                  decoration: BoxDecoration(
                                                    color: memory["type"] == "auto" ? Colors.blue.withAlpha(20) : Colors.green.withAlpha(20),
                                                    borderRadius: BorderRadius.circular(radiusXxs),
                                                  ),
                                                  child: Text(
                                                    "${memory["type"]}".toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: 8,
                                                      fontWeight: FontWeight.w600,
                                                      color: memory["type"] == "auto" ? Colors.blue : Colors.green,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: spXs),
                                            Text(
                                              "${memory["description"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: disabledBoldColor,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: spSm),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today,
                                                  size: 12,
                                                  color: disabledColor,
                                                ),
                                                SizedBox(width: spXs),
                                                Text(
                                                  DateTime.parse("${memory["date"]}").dMMMy,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: disabledColor,
                                                  ),
                                                ),
                                                if (memory["location"] != null) ...[
                                                  SizedBox(width: spMd),
                                                  Icon(
                                                    Icons.location_on,
                                                    size: 12,
                                                    color: disabledColor,
                                                  ),
                                                  SizedBox(width: spXs),
                                                  Expanded(
                                                    child: Text(
                                                      "${memory["location"]}",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: disabledColor,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      
                                      SizedBox(width: spSm),
                                      
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                        color: disabledColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
