import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaReadingListView extends StatefulWidget {
  const NmaReadingListView({super.key});

  @override
  State<NmaReadingListView> createState() => _NmaReadingListViewState();
}

class _NmaReadingListViewState extends State<NmaReadingListView> {
  String selectedList = "All Lists";
  String selectedSortBy = "Date Added";
  bool isEditMode = false;
  List<String> selectedArticles = [];

  List<Map<String, dynamic>> readingLists = [
    {
      "id": "all",
      "name": "All Lists",
      "count": 42,
      "color": primaryColor,
      "icon": Icons.list,
    },
    {
      "id": "1",
      "name": "Tech & Innovation",
      "count": 15,
      "color": Colors.blue,
      "icon": Icons.computer,
      "description": "Latest technology trends and innovations",
      "isDefault": false,
    },
    {
      "id": "2",
      "name": "Business News",
      "count": 12,
      "color": Colors.green,
      "icon": Icons.business,
      "description": "Market updates and business analysis",
      "isDefault": false,
    },
    {
      "id": "3",
      "name": "Weekend Reads",
      "count": 8,
      "color": Colors.orange,
      "icon": Icons.weekend,
      "description": "Long-form articles for leisure reading",
      "isDefault": false,
    },
    {
      "id": "4",
      "name": "Research Papers",
      "count": 5,
      "color": Colors.purple,
      "icon": Icons.school,
      "description": "Academic papers and research findings",
      "isDefault": false,
    },
    {
      "id": "5",
      "name": "Quick Reads",
      "count": 2,
      "color": Colors.red,
      "icon": Icons.flash_on,
      "description": "Short articles under 5 minutes",
      "isDefault": false,
    },
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Date Added", "value": "Date Added"},
    {"label": "Title (A-Z)", "value": "Title (A-Z)"},
    {"label": "Title (Z-A)", "value": "Title (Z-A)"},
    {"label": "Read Time", "value": "Read Time"},
    {"label": "Priority", "value": "Priority"},
    {"label": "Source", "value": "Source"},
  ];

  List<Map<String, dynamic>> articles = [
    {
      "id": "1",
      "title": "The Future of Quantum Computing",
      "source": "MIT Technology Review",
      "author": "Dr. Sarah Chen",
      "readTime": "12 min read",
      "addedDate": "2024-01-15",
      "priority": "High",
      "listId": "1",
      "listName": "Tech & Innovation",
      "image": "https://picsum.photos/400/250?random=1&keyword=quantum",
      "isRead": false,
      "progress": 0,
      "tags": ["Quantum", "Computing", "Future"],
      "summary": "Exploring the potential of quantum computing in various industries",
    },
    {
      "id": "2",
      "title": "Global Market Trends 2024",
      "source": "Financial Times",
      "author": "Michael Rodriguez",
      "readTime": "8 min read",
      "addedDate": "2024-01-14",
      "priority": "High",
      "listId": "2",
      "listName": "Business News",
      "image": "https://picsum.photos/400/250?random=2&keyword=market",
      "isRead": false,
      "progress": 35,
      "tags": ["Market", "Economy", "Trends"],
      "summary": "Analysis of emerging market trends and investment opportunities",
    },
    {
      "id": "3",
      "title": "The Art of Slow Living",
      "source": "The Atlantic",
      "author": "Emma Thompson",
      "readTime": "15 min read",
      "addedDate": "2024-01-13",
      "priority": "Medium",
      "listId": "3",
      "listName": "Weekend Reads",
      "image": "https://picsum.photos/400/250?random=3&keyword=lifestyle",
      "isRead": true,
      "progress": 100,
      "tags": ["Lifestyle", "Wellness", "Philosophy"],
      "summary": "How embracing a slower pace can improve quality of life",
    },
    {
      "id": "4",
      "title": "Climate Change Research Update",
      "source": "Nature",
      "author": "Dr. James Wilson",
      "readTime": "20 min read",
      "addedDate": "2024-01-12",
      "priority": "High",
      "listId": "4",
      "listName": "Research Papers",
      "image": "https://picsum.photos/400/250?random=4&keyword=climate",
      "isRead": false,
      "progress": 60,
      "tags": ["Climate", "Research", "Environment"],
      "summary": "Latest findings on climate change impacts and solutions",
    },
    {
      "id": "5",
      "title": "5 Productivity Tips for Remote Work",
      "source": "Harvard Business Review",
      "author": "Lisa Park",
      "readTime": "4 min read",
      "addedDate": "2024-01-11",
      "priority": "Low",
      "listId": "5",
      "listName": "Quick Reads",
      "image": "https://picsum.photos/400/250?random=5&keyword=productivity",
      "isRead": true,
      "progress": 100,
      "tags": ["Productivity", "Remote Work", "Tips"],
      "summary": "Simple strategies to boost productivity while working from home",
    },
    {
      "id": "6",
      "title": "AI in Healthcare: Current Applications",
      "source": "Medical News Today",
      "author": "Dr. Anna Kim",
      "readTime": "10 min read",
      "addedDate": "2024-01-10",
      "priority": "Medium",
      "listId": "1",
      "listName": "Tech & Innovation",
      "image": "https://picsum.photos/400/250?random=6&keyword=healthcare",
      "isRead": false,
      "progress": 25,
      "tags": ["AI", "Healthcare", "Medicine"],
      "summary": "How artificial intelligence is transforming medical practice",
    },
  ];

  List<Map<String, dynamic>> get filteredArticles {
    if (selectedList == "All Lists") {
      return articles;
    } else {
      final listData = readingLists.firstWhere((list) => list["name"] == selectedList);
      return articles.where((article) => article["listId"] == listData["id"]).toList();
    }
  }

  void _showCreateListDialog() {
    String listName = "";
    String description = "";
    Color selectedColor = Colors.blue;
    IconData selectedIcon = Icons.list;

    List<Color> colors = [
      Colors.blue, Colors.green, Colors.orange, Colors.purple,
      Colors.red, Colors.teal, Colors.indigo, Colors.pink,
    ];

    List<IconData> icons = [
      Icons.list, Icons.bookmark, Icons.star, Icons.favorite,
      Icons.work, Icons.school, Icons.sports, Icons.travel_explore,
      Icons.restaurant, Icons.fitness_center, Icons.music_note, Icons.palette,
    ];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text("Create Reading List"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QTextField(
                  label: "List Name",
                  value: listName,
                  onChanged: (value) {
                    listName = value;
                  },
                ),
                SizedBox(height: spSm),
                QTextField(
                  label: "Description (Optional)",
                  value: description,
                  onChanged: (value) {
                    description = value;
                  },
                ),
                SizedBox(height: spMd),
                Text(
                  "Choose Color",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: spSm),
                Wrap(
                  spacing: spXs,
                  children: colors.map((color) {
                    bool isSelected = selectedColor == color;
                    return GestureDetector(
                      onTap: () {
                        selectedColor = color;
                        setDialogState(() {});
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? Colors.black : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? Icon(Icons.check, color: Colors.white, size: 16)
                            : null,
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: spMd),
                Text(
                  "Choose Icon",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: spSm),
                Wrap(
                  spacing: spXs,
                  children: icons.map((icon) {
                    bool isSelected = selectedIcon == icon;
                    return GestureDetector(
                      onTap: () {
                        selectedIcon = icon;
                        setDialogState(() {});
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isSelected ? selectedColor.withAlpha(20) : Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? selectedColor : disabledColor,
                          ),
                        ),
                        child: Icon(
                          icon,
                          color: isSelected ? selectedColor : disabledBoldColor,
                          size: 20,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Create",
              size: bs.sm,
              onPressed: () {
                if (listName.isNotEmpty) {
                  Navigator.pop(context);
                  ss("Reading list '$listName' created successfully");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showListOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledColor)),
              ),
              child: Row(
                children: [
                  Text(
                    "List Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: disabledBoldColor),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  _buildListOption(
                    icon: Icons.add,
                    title: "Create New List",
                    onTap: () {
                      Navigator.pop(context);
                      _showCreateListDialog();
                    },
                  ),
                  _buildListOption(
                    icon: Icons.edit,
                    title: "Manage Lists",
                    onTap: () {
                      Navigator.pop(context);
                      isEditMode = !isEditMode;
                      setState(() {});
                      si("Edit mode ${isEditMode ? 'enabled' : 'disabled'}");
                    },
                  ),
                  _buildListOption(
                    icon: Icons.sort,
                    title: "Sort Articles",
                    onTap: () {
                      Navigator.pop(context);
                      _showSortOptions();
                    },
                  ),
                  _buildListOption(
                    icon: Icons.import_export,
                    title: "Import/Export",
                    onTap: () {
                      Navigator.pop(context);
                      si("Import/Export feature coming soon");
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

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledColor)),
              ),
              child: Row(
                children: [
                  Text(
                    "Sort Articles",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: disabledBoldColor),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: sortOptions.map((option) {
                  bool isSelected = selectedSortBy == option["value"];
                  return GestureDetector(
                    onTap: () {
                      selectedSortBy = option["value"];
                      setState(() {});
                      Navigator.pop(context);
                      ss("Sorted by ${option["label"]}");
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      child: Row(
                        children: [
                          Icon(
                            isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                            color: isSelected ? primaryColor : disabledBoldColor,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${option["label"]}",
                            style: TextStyle(
                              color: isSelected ? primaryColor : Colors.black,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spSm),
        child: Row(
          children: [
            Icon(icon, color: primaryColor),
            SizedBox(width: spMd),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadingListCard(Map<String, dynamic> list) {
    bool isSelected = selectedList == list["name"];
    
    return GestureDetector(
      onTap: () {
        selectedList = list["name"];
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isSelected ? (list["color"] as Color).withAlpha(20) : Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? list["color"] as Color : disabledColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [shadowSm],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: list["color"] as Color,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                list["icon"] as IconData,
                color: Colors.white,
                size: 24,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${list["name"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? list["color"] as Color : Colors.black,
                    ),
                  ),
                  if (list["description"] != null) ...[
                    SizedBox(height: 2),
                    Text(
                      "${list["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
              decoration: BoxDecoration(
                color: (list["color"] as Color).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "${list["count"]}",
                style: TextStyle(
                  color: list["color"] as Color,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (isEditMode && list["id"] != "all") ...[
              SizedBox(width: spSm),
              GestureDetector(
                onTap: () async {
                  bool isConfirmed = await confirm("Delete reading list '${list["name"]}'?");
                  if (isConfirmed) {
                    ss("Reading list deleted");
                  }
                },
                child: Icon(
                  Icons.delete,
                  color: dangerColor,
                  size: 20,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildArticleCard(Map<String, dynamic> article) {
    double progress = (article["progress"] as int) / 100.0;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                child: Image.network(
                  "${article["image"]}",
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spXs,
                left: spXs,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${article["listName"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: spXs,
                right: spXs,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: article["priority"] == "High"
                        ? dangerColor
                        : article["priority"] == "Medium"
                            ? warningColor
                            : successColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${article["priority"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              if (progress > 0)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 4,
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        article["isRead"] == true ? successColor : primaryColor,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${article["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: article["isRead"] == true ? disabledBoldColor : Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Text(
                  "${article["summary"]}",
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
                    Text(
                      "${article["source"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${article["readTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    if (progress > 0 && !article["isRead"])
                      Text(
                        "${(progress * 100).toInt()}% read",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    if (article["isRead"] == true)
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 16,
                      ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: spXs,
                        children: (article["tags"] as List).take(2).map((tag) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$tag",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: article["isRead"] == true ? "Read Again" : "Continue",
                      size: bs.sm,
                      onPressed: () {
                        // Navigate to reader
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reading Lists"),
        actions: [
          if (isEditMode)
            GestureDetector(
              onTap: () {
                isEditMode = false;
                setState(() {});
              },
              child: Padding(
                padding: EdgeInsets.all(spSm),
                child: Icon(Icons.done),
              ),
            ),
          GestureDetector(
            onTap: _showListOptions,
            child: Padding(
              padding: EdgeInsets.all(spSm),
              child: Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              itemCount: readingLists.length,
              itemBuilder: (context, index) {
                final list = readingLists[index];
                return Container(
                  width: 280,
                  margin: EdgeInsets.only(right: spSm),
                  child: _buildReadingListCard(list),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            color: Colors.grey[50],
            child: Row(
              children: [
                Text(
                  "${filteredArticles.length} articles in $selectedList",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  "Sorted by $selectedSortBy",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: filteredArticles.length,
              itemBuilder: (context, index) {
                final article = filteredArticles[index];
                return _buildArticleCard(article);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateListDialog,
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
