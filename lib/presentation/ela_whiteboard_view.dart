import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaWhiteboardView extends StatefulWidget {
  const ElaWhiteboardView({super.key});

  @override
  State<ElaWhiteboardView> createState() => _ElaWhiteboardViewState();
}

class _ElaWhiteboardViewState extends State<ElaWhiteboardView> {
  String selectedTool = "pen";
  String selectedColor = "black";
  double selectedThickness = 2.0;
  int selectedTab = 0;
  
  List<Map<String, dynamic>> whiteboards = [
    {
      "id": 1,
      "title": "Math Lesson - Algebra",
      "subject": "Mathematics",
      "date": "2024-12-18",
      "participants": 24,
      "duration": "45 min",
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=whiteboard+math",
      "status": "active",
      "tools_used": ["pen", "highlighter", "shapes"],
    },
    {
      "id": 2,
      "title": "Science - Cell Biology",
      "subject": "Biology",
      "date": "2024-12-17",
      "participants": 18,
      "duration": "60 min",
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=science+diagram",
      "status": "completed",
      "tools_used": ["pen", "text", "images"],
    },
    {
      "id": 3,
      "title": "History Timeline",
      "subject": "History",
      "date": "2024-12-16",
      "participants": 22,
      "duration": "40 min",
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=timeline+history",
      "status": "scheduled",
      "tools_used": ["pen", "shapes", "text"],
    },
  ];

  List<Map<String, dynamic>> tools = [
    {"name": "pen", "icon": Icons.edit, "color": Colors.black},
    {"name": "highlighter", "icon": Icons.border_color, "color": Colors.yellow},
    {"name": "eraser", "icon": Icons.clear, "color": Colors.grey},
    {"name": "shapes", "icon": Icons.crop_square, "color": Colors.blue},
    {"name": "text", "icon": Icons.text_fields, "color": Colors.green},
    {"name": "sticky", "icon": Icons.note, "color": Colors.orange},
  ];

  List<String> colorPalette = ["black", "red", "blue", "green", "purple", "orange"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Interactive Whiteboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Tool Bar
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                // Drawing Tools
                Row(
                  children: [
                    Text(
                      "Tools:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QHorizontalScroll(
                        children: tools.map((tool) {
                          bool isSelected = selectedTool == tool["name"];
                          return GestureDetector(
                            onTap: () {
                              selectedTool = tool["name"];
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              margin: EdgeInsets.only(right: spXs),
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: isSelected ? primaryColor : disabledOutlineBorderColor,
                                ),
                              ),
                              child: Icon(
                                tool["icon"],
                                color: isSelected ? Colors.white : disabledBoldColor,
                                size: 20,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),

                // Color Palette & Thickness
                if (selectedTool == "pen" || selectedTool == "highlighter")
                  Row(
                    children: [
                      Text(
                        "Color:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Row(
                          children: colorPalette.map((color) {
                            bool isSelected = selectedColor == color;
                            Color colorValue = _getColorFromName(color);
                            return GestureDetector(
                              onTap: () {
                                selectedColor = color;
                                setState(() {});
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                margin: EdgeInsets.only(right: spXs),
                                decoration: BoxDecoration(
                                  color: colorValue,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                                    width: isSelected ? 3 : 1,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Text(
                        "Size: ${selectedThickness.toInt()}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Container(
                        width: 100,
                        child: Slider(
                          value: selectedThickness,
                          min: 1,
                          max: 10,
                          divisions: 9,
                          activeColor: primaryColor,
                          onChanged: (value) {
                            selectedThickness = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),

          // Main Content Area
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Active Whiteboard Canvas
                  Container(
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowMd],
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Stack(
                      children: [
                        // Grid Pattern
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://picsum.photos/800/400?random=99&keyword=whiteboard+grid"),
                              fit: BoxFit.cover,
                              opacity: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                        ),

                        // Drawing Area Placeholder
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit,
                                size: 48,
                                color: disabledColor,
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "Start drawing on the whiteboard",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Selected: ${selectedTool.toUpperCase()} - ${selectedColor.toUpperCase()}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Action Buttons
                        Positioned(
                          top: spSm,
                          right: spSm,
                          child: Row(
                            children: [
                              QButton(
                                icon: Icons.undo,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.redo,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.clear_all,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Whiteboard Sessions
                  Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Recent Sessions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),

                  // Sessions List
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: whiteboards.map((board) {
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
                            Stack(
                              children: [
                                Container(
                                  height: 120,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(radiusMd),
                                      topRight: Radius.circular(radiusMd),
                                    ),
                                    child: Image.network(
                                      "${board["thumbnail"]}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                // Status Badge
                                Positioned(
                                  top: spSm,
                                  left: spSm,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(board["status"]),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${board["status"]}".toUpperCase(),
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

                            // Session Details
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "${board["title"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  Text(
                                    "${board["subject"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.people,
                                        size: 14,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${board["participants"]} participants",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.schedule,
                                        size: 14,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${board["duration"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Tools Used
                                  Wrap(
                                    spacing: spXs,
                                    children: (board["tools_used"] as List).map((tool) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(25),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "$tool",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),

                                  // Action Button
                                  Container(
                                    width: double.infinity,
                                    child: QButton(
                                      label: board["status"] == "active" ? "Continue" : "View",
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

                  // Quick Actions
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor.withAlpha(25), secondaryColor.withAlpha(25)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Quick Actions",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "New Session",
                                icon: Icons.add,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Import",
                                icon: Icons.upload,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Templates",
                                icon: Icons.library_books,
                                size: bs.sm,
                                onPressed: () {},
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
        ],
      ),
    );
  }

  Color _getColorFromName(String colorName) {
    switch (colorName) {
      case "red": return Colors.red;
      case "blue": return Colors.blue;
      case "green": return Colors.green;
      case "purple": return Colors.purple;
      case "orange": return Colors.orange;
      default: return Colors.black;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active": return successColor;
      case "completed": return primaryColor;
      case "scheduled": return warningColor;
      default: return disabledBoldColor;
    }
  }
}
