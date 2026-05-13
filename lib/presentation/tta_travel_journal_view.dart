import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaTravelJournalView extends StatefulWidget {
  const TtaTravelJournalView({super.key});

  @override
  State<TtaTravelJournalView> createState() => _TtaTravelJournalViewState();
}

class _TtaTravelJournalViewState extends State<TtaTravelJournalView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  
  final List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Adventure", "value": "Adventure"},
    {"label": "Beach", "value": "Beach"},
    {"label": "City", "value": "City"},
    {"label": "Nature", "value": "Nature"},
    {"label": "Cultural", "value": "Cultural"},
    {"label": "Food", "value": "Food"},
  ];

  final List<Map<String, dynamic>> journalEntries = [
    {
      "id": "1",
      "title": "Amazing Weekend in Paris",
      "destination": "Paris, France",
      "date": "2024-06-20",
      "duration": "3 days",
      "category": "City",
      "rating": 5.0,
      "coverImage": "https://picsum.photos/300/200?random=1&keyword=paris",
      "images": [
        "https://picsum.photos/200/150?random=2&keyword=eiffel",
        "https://picsum.photos/200/150?random=3&keyword=louvre",
        "https://picsum.photos/200/150?random=4&keyword=seine",
      ],
      "description": "Incredible weekend exploring the City of Light. From the Eiffel Tower to the Louvre, every moment was magical.",
      "highlights": [
        "Sunset at Eiffel Tower",
        "Mona Lisa at Louvre",
        "Seine River cruise",
        "Montmartre district"
      ],
      "expenses": 1250.00,
      "tags": ["romantic", "museums", "architecture", "food"],
      "weather": "Sunny, 22°C",
      "memories": 15,
      "favorite": true
    },
    {
      "id": "2", 
      "title": "Tropical Paradise in Bali",
      "destination": "Bali, Indonesia",
      "date": "2024-06-01",
      "duration": "7 days",
      "category": "Beach",
      "rating": 4.8,
      "coverImage": "https://picsum.photos/300/200?random=5&keyword=bali",
      "images": [
        "https://picsum.photos/200/150?random=6&keyword=beach",
        "https://picsum.photos/200/150?random=7&keyword=temple",
        "https://picsum.photos/200/150?random=8&keyword=ricefield",
      ],
      "description": "Week-long adventure in the beautiful island of Bali. Perfect mix of relaxation, culture, and adventure.",
      "highlights": [
        "Uluwatu Temple sunset",
        "Rice terrace trekking",
        "Traditional cooking class",
        "Snorkeling at Nusa Penida"
      ],
      "expenses": 890.00,
      "tags": ["beach", "culture", "relaxation", "adventure"],
      "weather": "Tropical, 28°C",
      "memories": 28,
      "favorite": false
    },
    {
      "id": "3",
      "title": "Mountain Hiking Adventure",
      "destination": "Swiss Alps, Switzerland", 
      "date": "2024-05-15",
      "duration": "5 days",
      "category": "Nature",
      "rating": 4.9,
      "coverImage": "https://picsum.photos/300/200?random=9&keyword=mountains",
      "images": [
        "https://picsum.photos/200/150?random=10&keyword=hiking",
        "https://picsum.photos/200/150?random=11&keyword=lake",
        "https://picsum.photos/200/150?random=12&keyword=alps",
      ],
      "description": "Breathtaking hiking experience in the Swiss Alps. Crystal clear lakes and stunning mountain views.",
      "highlights": [
        "Matterhorn viewpoint",
        "Lake Geneva boat ride", 
        "Alpine village stay",
        "Mountain railway journey"
      ],
      "expenses": 1680.00,
      "tags": ["hiking", "nature", "mountains", "adventure"],
      "weather": "Cool, 15°C",
      "memories": 22,
      "favorite": true
    },
    {
      "id": "4",
      "title": "Cultural Journey in Tokyo",
      "destination": "Tokyo, Japan",
      "date": "2024-04-28",
      "duration": "6 days", 
      "category": "Cultural",
      "rating": 4.7,
      "coverImage": "https://picsum.photos/300/200?random=13&keyword=tokyo",
      "images": [
        "https://picsum.photos/200/150?random=14&keyword=temple",
        "https://picsum.photos/200/150?random=15&keyword=sushi",
        "https://picsum.photos/200/150?random=16&keyword=cherry",
      ],
      "description": "Immersive cultural experience in Tokyo. From ancient temples to modern technology and amazing food.",
      "highlights": [
        "Cherry blossom viewing",
        "Sushi making class",
        "Senso-ji Temple visit",
        "Shibuya crossing experience"
      ],
      "expenses": 1420.00,
      "tags": ["culture", "food", "temples", "city"],
      "weather": "Mild, 18°C", 
      "memories": 31,
      "favorite": false
    }
  ];

  List<Map<String, dynamic>> get filteredEntries {
    return journalEntries.where((entry) {
      final matchesSearch = entry["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                           entry["destination"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == "All" || entry["category"] == selectedCategory;
      
      if (selectedTab == 0) return matchesSearch && matchesCategory; // All
      if (selectedTab == 1) return matchesSearch && matchesCategory && entry["favorite"]; // Favorites
      if (selectedTab == 2) { // Recent (last 30 days)
        final entryDate = DateTime.parse(entry["date"]);
        final now = DateTime.now();
        final difference = now.difference(entryDate).inDays;
        return matchesSearch && matchesCategory && difference <= 30;
      }
      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Journal"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add entry
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilter(),
          _buildTabBar(),
          Expanded(
            child: _buildJournalContent(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add new entry
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search journals...",
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
          
          QCategoryPicker(
            items: categories,
            value: selectedCategory,
            onChanged: (index, label, value, item) {
              selectedCategory = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      child: Row(
        children: [
          Expanded(
            child: _buildTabButton("All", 0),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: _buildTabButton("Favorites", 1),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: _buildTabButton("Recent", 2),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = selectedTab == index;
    
    return GestureDetector(
      onTap: () {
        selectedTab = index;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : disabledBoldColor,
          ),
        ),
      ),
    );
  }

  Widget _buildJournalContent() {
    final entries = filteredEntries;
    
    if (entries.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.book,
              size: 80,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No journal entries found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Start documenting your travel adventures!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Create First Entry",
              size: bs.md,
              onPressed: () {
                // Navigate to add entry
              },
            ),
          ],
        ),
      );
    }
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          _buildStatsOverview(),
          SizedBox(height: spMd),
          Column(
            children: entries.map((entry) => _buildJournalCard(entry)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsOverview() {
    final totalEntries = journalEntries.length;
    final totalDestinations = journalEntries.map((e) => e["destination"]).toSet().length;
    final totalExpenses = journalEntries.fold<double>(0, (sum, entry) => sum + (entry["expenses"] as double));
    final averageRating = journalEntries.fold<double>(0, (sum, entry) => sum + (entry["rating"] as double)) / totalEntries;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(51)),
      ),
      child: Column(
        children: [
          Text(
            "Travel Statistics",
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
                child: _buildStatItem(
                  icon: Icons.book,
                  label: "Entries",
                  value: "$totalEntries",
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.location_on,
                  label: "Destinations", 
                  value: "$totalDestinations",
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.attach_money,
                  label: "Total Spent",
                  value: "\$${totalExpenses.toStringAsFixed(0)}",
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.star,
                  label: "Avg Rating",
                  value: "${averageRating.toStringAsFixed(1)}",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: primaryColor, size: 24),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
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

  Widget _buildJournalCard(Map<String, dynamic> entry) {
    return Container(
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
          _buildJournalCardHeader(entry),
          _buildJournalCardContent(entry),
          _buildJournalCardFooter(entry),
        ],
      ),
    );
  }

  Widget _buildJournalCardHeader(Map<String, dynamic> entry) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
          child: Image.network(
            "${entry["coverImage"]}",
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        
        Positioned(
          top: spSm,
          right: spSm,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(128),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${entry["category"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              GestureDetector(
                onTap: () {
                  // Toggle favorite
                  entry["favorite"] = !entry["favorite"];
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(128),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    entry["favorite"] ? Icons.favorite : Icons.favorite_border,
                    color: entry["favorite"] ? dangerColor : Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        Positioned(
          bottom: spSm,
          left: spSm,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(128),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.photo_library, color: Colors.white, size: 16),
                SizedBox(width: spXs),
                Text(
                  "${(entry["images"] as List).length} photos",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildJournalCardContent(Map<String, dynamic> entry) {
    return Padding(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${entry["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    size: 16,
                    color: index < (entry["rating"] as double)
                        ? successColor
                        : disabledColor,
                  );
                }),
              ),
            ],
          ),
          
          SizedBox(height: spXs),
          
          Row(
            children: [
              Icon(Icons.location_on, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${entry["destination"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.calendar_today, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${DateTime.parse(entry["date"]).dMMMy}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Text(
            "${entry["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          SizedBox(height: spSm),
          
          // Highlights
          Text(
            "Highlights:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Column(
            children: (entry["highlights"] as List).take(2).map((highlight) {
              return Padding(
                padding: EdgeInsets.only(bottom: spXs),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: successColor, size: 14),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "$highlight",
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
          ),
          
          if ((entry["highlights"] as List).length > 2)
            Text(
              "+${(entry["highlights"] as List).length - 2} more highlights",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildJournalCardFooter(Map<String, dynamic> entry) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(25),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(radiusMd)),
      ),
      child: Row(
        children: [
          Icon(Icons.access_time, color: primaryColor, size: 16),
          SizedBox(width: spXs),
          Text(
            "${entry["duration"]}",
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
            ),
          ),
          
          SizedBox(width: spMd),
          
          Icon(Icons.attach_money, color: primaryColor, size: 16),
          SizedBox(width: spXs),
          Text(
            "\$${(entry["expenses"] as double).toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
            ),
          ),
          
          SizedBox(width: spMd),
          
          Icon(Icons.photo, color: primaryColor, size: 16),
          SizedBox(width: spXs),
          Text(
            "${entry["memories"]} memories",
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
            ),
          ),
          
          Spacer(),
          
          QButton(
            label: "View",
            size: bs.sm,
            onPressed: () {
              // Navigate to entry detail
            },
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    // Show filter options dialog
    si("Filter options coming soon");
  }
}
