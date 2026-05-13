import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaReadingMaterialView extends StatefulWidget {
  const ElaReadingMaterialView({super.key});

  @override
  State<ElaReadingMaterialView> createState() => _ElaReadingMaterialViewState();
}

class _ElaReadingMaterialViewState extends State<ElaReadingMaterialView> {
  bool loading = true;
  String searchQuery = "";
  String selectedCategory = "All Categories";
  String selectedGrade = "All Grades";
  String selectedDifficulty = "All Levels";
  String viewMode = "grid"; // grid or list

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Fiction", "value": "Fiction"},
    {"label": "Non-Fiction", "value": "Non-Fiction"},
    {"label": "Poetry", "value": "Poetry"},
    {"label": "Drama", "value": "Drama"},
    {"label": "Biography", "value": "Biography"},
    {"label": "Science", "value": "Science"},
    {"label": "History", "value": "History"},
  ];

  List<Map<String, dynamic>> gradeOptions = [
    {"label": "All Grades", "value": "All Grades"},
    {"label": "Grade 1", "value": "Grade 1"},
    {"label": "Grade 2", "value": "Grade 2"},
    {"label": "Grade 3", "value": "Grade 3"},
    {"label": "Grade 4", "value": "Grade 4"},
    {"label": "Grade 5", "value": "Grade 5"},
    {"label": "Grade 6", "value": "Grade 6"},
  ];

  List<Map<String, dynamic>> difficultyOptions = [
    {"label": "All Levels", "value": "All Levels"},
    {"label": "Beginner", "value": "Beginner"},
    {"label": "Intermediate", "value": "Intermediate"},
    {"label": "Advanced", "value": "Advanced"},
  ];

  List<Map<String, dynamic>> readingMaterials = [
    {
      "id": "material_001",
      "title": "The Adventures of Tom Sawyer",
      "author": "Mark Twain",
      "category": "Fiction",
      "grade": "Grade 5",
      "difficulty": "Intermediate",
      "pages": 156,
      "readingTime": "3-4 hours",
      "description": "Follow Tom Sawyer on his mischievous adventures along the Mississippi River in this classic American novel.",
      "thumbnail": "https://picsum.photos/300/400?random=1&keyword=book",
      "rating": 4.6,
      "downloads": 2567,
      "isBookmarked": false,
      "progress": 0,
      "lastRead": null,
      "format": "PDF",
      "fileSize": "2.4 MB",
      "publishedDate": "2024-01-15",
      "tags": ["Adventure", "Classic", "American Literature"],
      "comprehensionQuestions": 15,
      "hasAudio": true,
    },
    {
      "id": "material_002",
      "title": "The Water Cycle",
      "author": "Dr. Sarah Chen",
      "category": "Science",
      "grade": "Grade 3",
      "difficulty": "Beginner",
      "pages": 24,
      "readingTime": "30-45 minutes",
      "description": "Learn about evaporation, condensation, and precipitation in this engaging science reader.",
      "thumbnail": "https://picsum.photos/300/400?random=2&keyword=science",
      "rating": 4.8,
      "downloads": 3421,
      "isBookmarked": true,
      "progress": 75,
      "lastRead": "2024-03-15",
      "format": "PDF",
      "fileSize": "1.8 MB",
      "publishedDate": "2024-02-01",
      "tags": ["Water", "Environment", "Earth Science"],
      "comprehensionQuestions": 8,
      "hasAudio": true,
    },
    {
      "id": "material_003",
      "title": "Maya Angelou: A Life of Courage",
      "author": "Jennifer Rodriguez",
      "category": "Biography",
      "grade": "Grade 6",
      "difficulty": "Advanced",
      "pages": 87,
      "readingTime": "2-3 hours",
      "description": "Discover the inspiring life story of poet and civil rights activist Maya Angelou.",
      "thumbnail": "https://picsum.photos/300/400?random=3&keyword=biography",
      "rating": 4.9,
      "downloads": 1876,
      "isBookmarked": false,
      "progress": 0,
      "lastRead": null,
      "format": "PDF",
      "fileSize": "3.2 MB",
      "publishedDate": "2024-02-20",
      "tags": ["Civil Rights", "Poetry", "Inspiration"],
      "comprehensionQuestions": 12,
      "hasAudio": false,
    },
    {
      "id": "material_004",
      "title": "Poems About Nature",
      "author": "Various Authors",
      "category": "Poetry",
      "grade": "Grade 4",
      "difficulty": "Intermediate",
      "pages": 45,
      "readingTime": "1-2 hours",
      "description": "A beautiful collection of poems celebrating the natural world and our environment.",
      "thumbnail": "https://picsum.photos/300/400?random=4&keyword=poetry",
      "rating": 4.4,
      "downloads": 1234,
      "isBookmarked": true,
      "progress": 100,
      "lastRead": "2024-03-10",
      "format": "PDF",
      "fileSize": "1.5 MB",
      "publishedDate": "2024-01-30",
      "tags": ["Nature", "Environment", "Imagery"],
      "comprehensionQuestions": 6,
      "hasAudio": true,
    },
    {
      "id": "material_005",
      "title": "The American Revolution",
      "author": "Prof. Michael Johnson",
      "category": "History",
      "grade": "Grade 5",
      "difficulty": "Intermediate",
      "pages": 92,
      "readingTime": "2-3 hours",
      "description": "Explore the causes, events, and consequences of the American Revolution in this comprehensive historical account.",
      "thumbnail": "https://picsum.photos/300/400?random=5&keyword=history",
      "rating": 4.7,
      "downloads": 2890,
      "isBookmarked": false,
      "progress": 45,
      "lastRead": "2024-03-12",
      "format": "PDF",
      "fileSize": "2.8 MB",
      "publishedDate": "2024-02-10",
      "tags": ["American History", "War", "Independence"],
      "comprehensionQuestions": 18,
      "hasAudio": false,
    },
    {
      "id": "material_006",
      "title": "Charlotte's Web",
      "author": "E.B. White",
      "category": "Fiction",
      "grade": "Grade 3",
      "difficulty": "Beginner",
      "pages": 184,
      "readingTime": "3-4 hours",
      "description": "The heartwarming story of a pig named Wilbur and his friendship with Charlotte the spider.",
      "thumbnail": "https://picsum.photos/300/400?random=6&keyword=children",
      "rating": 4.9,
      "downloads": 4567,
      "isBookmarked": true,
      "progress": 100,
      "lastRead": "2024-03-08",
      "format": "PDF",
      "fileSize": "2.1 MB",
      "publishedDate": "2024-01-05",
      "tags": ["Friendship", "Animals", "Classic"],
      "comprehensionQuestions": 20,
      "hasAudio": true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadReadingMaterials();
  }

  void _loadReadingMaterials() async {
    await Future.delayed(Duration(seconds: 2));
    loading = false;
    setState(() {});
  }

  List<Map<String, dynamic>> get filteredMaterials {
    return readingMaterials.where((material) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${material["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${material["author"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${material["category"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All Categories" || 
          material["category"] == selectedCategory;
      
      bool matchesGrade = selectedGrade == "All Grades" || 
          material["grade"] == selectedGrade;
      
      bool matchesDifficulty = selectedDifficulty == "All Levels" || 
          material["difficulty"] == selectedDifficulty;
      
      return matchesSearch && matchesCategory && matchesGrade && matchesDifficulty;
    }).toList();
  }

  void _toggleBookmark(String materialId) {
    int index = readingMaterials.indexWhere((m) => m["id"] == materialId);
    if (index != -1) {
      readingMaterials[index]["isBookmarked"] = !readingMaterials[index]["isBookmarked"];
      setState(() {});
      
      String message = readingMaterials[index]["isBookmarked"] 
          ? "Added to bookmarks" 
          : "Removed from bookmarks";
      ss(message);
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Beginner":
        return successColor;
      case "Intermediate":
        return warningColor;
      case "Advanced":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Widget _buildStarRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor()
              ? Icons.star
              : index < rating
                  ? Icons.star_half
                  : Icons.star_border,
          color: warningColor,
          size: 14,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Reading Materials"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Reading Materials"),
        actions: [
          IconButton(
            icon: Icon(viewMode == "grid" ? Icons.list : Icons.grid_view),
            onPressed: () {
              viewMode = viewMode == "grid" ? "list" : "grid";
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              // Show bookmarked materials
            },
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
                    label: "Search reading materials...",
                    value: searchQuery,
                    hint: "Search by title, author, or category",
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

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categoryOptions,
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
                    label: "Grade",
                    items: gradeOptions,
                    value: selectedGrade,
                    onChanged: (value, label) {
                      selectedGrade = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Difficulty",
                    items: difficultyOptions,
                    value: selectedDifficulty,
                    onChanged: (value, label) {
                      selectedDifficulty = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Results Count
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${filteredMaterials.length} materials found",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "View:",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                      GestureDetector(
                        onTap: () {
                          viewMode = "grid";
                          setState(() {});
                        },
                        child: Icon(
                          Icons.grid_view,
                          size: 20,
                          color: viewMode == "grid" ? primaryColor : disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                      GestureDetector(
                        onTap: () {
                          viewMode = "list";
                          setState(() {});
                        },
                        child: Icon(
                          Icons.list,
                          size: 20,
                          color: viewMode == "list" ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Materials Display
            if (viewMode == "grid")
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredMaterials.map((material) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Thumbnail
                        Container(
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(radiusMd),
                            ),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(radiusMd),
                                ),
                                child: Image.network(
                                  "${material["thumbnail"]}",
                                  width: double.infinity,
                                  height: 160,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: spXs,
                                right: spXs,
                                child: GestureDetector(
                                  onTap: () => _toggleBookmark("${material["id"]}"),
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                    child: Icon(
                                      material["isBookmarked"] 
                                          ? Icons.bookmark 
                                          : Icons.bookmark_border,
                                      size: 18,
                                      color: material["isBookmarked"] 
                                          ? primaryColor 
                                          : disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ),
                              if (material["progress"] > 0)
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withValues(alpha: 0.3),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: (material["progress"] as num) / 100,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (material["hasAudio"])
                                Positioned(
                                  top: spXs,
                                  left: spXs,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Icon(
                                      Icons.volume_up,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),

                        // Content
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title
                                Text(
                                  "${material["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 2),

                                // Author
                                Text(
                                  "by ${material["author"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                SizedBox(height: spXs),

                                // Category & Grade
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${material["category"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: secondaryColor.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${material["grade"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: secondaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),

                                // Description
                                Text(
                                  "${material["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: spXs),

                                // Stats
                                Row(
                                  children: [
                                    _buildStarRating(material["rating"] as double),
                                    SizedBox(width: 4),
                                    Text(
                                      "${material["rating"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getDifficultyColor("${material["difficulty"]}").withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${material["difficulty"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: _getDifficultyColor("${material["difficulty"]}"),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),

                                // Progress
                                if (material["progress"] > 0)
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Progress",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: disabledBoldColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "${material["progress"]}%",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: primaryColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                    ],
                                  ),

                                // File Info
                                Row(
                                  children: [
                                    Icon(
                                      Icons.description,
                                      size: 12,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "${material["format"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${material["fileSize"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${material["pages"]} pages",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                
                                Spacer(),

                                // Action Button
                                Container(
                                  width: double.infinity,
                                  child: QButton(
                                    label: material["progress"] == 0 
                                        ? "Read Now" 
                                        : material["progress"] == 100 
                                            ? "Read Again" 
                                            : "Continue",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Open reading material
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )
            else
              Column(
                children: filteredMaterials.map((material) {
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
                        // Thumbnail
                        Container(
                          width: 80,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  "${material["thumbnail"]}",
                                  width: 80,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              if (material["hasAudio"])
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Icon(
                                      Icons.volume_up,
                                      size: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),

                        // Content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title and Bookmark
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${material["title"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  GestureDetector(
                                    onTap: () => _toggleBookmark("${material["id"]}"),
                                    child: Icon(
                                      material["isBookmarked"] 
                                          ? Icons.bookmark 
                                          : Icons.bookmark_border,
                                      size: 20,
                                      color: material["isBookmarked"] 
                                          ? primaryColor 
                                          : disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2),

                              // Author
                              Text(
                                "by ${material["author"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              SizedBox(height: spXs),

                              // Tags
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${material["category"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: secondaryColor.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${material["grade"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: secondaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getDifficultyColor("${material["difficulty"]}").withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${material["difficulty"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _getDifficultyColor("${material["difficulty"]}"),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),

                              // Description
                              Text(
                                "${material["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spXs),

                              // Stats
                              Row(
                                children: [
                                  _buildStarRating(material["rating"] as double),
                                  SizedBox(width: 4),
                                  Text(
                                    "${material["rating"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.download,
                                    size: 12,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "${material["downloads"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${material["pages"]} pages",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${material["readingTime"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),

                              // Progress
                              if (material["progress"] > 0)
                                Column(
                                  children: [
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
                                        Text(
                                          "Progress: ${material["progress"]}%",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        Expanded(
                                          child: Container(
                                            height: 4,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.withValues(alpha: 0.2),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: FractionallySizedBox(
                                              alignment: Alignment.centerLeft,
                                              widthFactor: (material["progress"] as num) / 100,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius: BorderRadius.circular(radiusXs),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),

                        // Action Button
                        QButton(
                          label: material["progress"] == 0 
                              ? "Read" 
                              : material["progress"] == 100 
                                  ? "Review" 
                                  : "Continue",
                          size: bs.sm,
                          onPressed: () {
                            // Open reading material
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
