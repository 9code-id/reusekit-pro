import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaUndoRedoView extends StatefulWidget {
  const PpaUndoRedoView({super.key});

  @override
  State<PpaUndoRedoView> createState() => _PpaUndoRedoViewState();
}

class _PpaUndoRedoViewState extends State<PpaUndoRedoView> {
  int currentStateIndex = 5;
  bool showThumbnails = true;
  bool autoSave = true;
  int maxHistoryStates = 20;

  final List<Map<String, dynamic>> historyStates = [
    {
      "id": "state_0",
      "title": "Original Image",
      "description": "Base image loaded",
      "timestamp": DateTime.now().subtract(Duration(minutes: 15)),
      "thumbnail": "https://picsum.photos/200/200?random=1",
      "changes": [],
      "type": "import",
    },
    {
      "id": "state_1",
      "title": "Brightness Adjustment",
      "description": "Increased brightness by +12%",
      "timestamp": DateTime.now().subtract(Duration(minutes: 14)),
      "thumbnail": "https://picsum.photos/200/200?random=2",
      "changes": ["brightness: +12%"],
      "type": "adjustment",
    },
    {
      "id": "state_2",
      "title": "Contrast Enhancement",
      "description": "Enhanced contrast by +8%",
      "timestamp": DateTime.now().subtract(Duration(minutes: 12)),
      "thumbnail": "https://picsum.photos/200/200?random=3",
      "changes": ["brightness: +12%", "contrast: +8%"],
      "type": "adjustment",
    },
    {
      "id": "state_3",
      "title": "Color Saturation",
      "description": "Boosted saturation by +15%",
      "timestamp": DateTime.now().subtract(Duration(minutes: 10)),
      "thumbnail": "https://picsum.photos/200/200?random=4",
      "changes": ["brightness: +12%", "contrast: +8%", "saturation: +15%"],
      "type": "adjustment",
    },
    {
      "id": "state_4",
      "title": "Applied Filter",
      "description": "Applied Vintage filter",
      "timestamp": DateTime.now().subtract(Duration(minutes: 8)),
      "thumbnail": "https://picsum.photos/200/200?random=5",
      "changes": ["brightness: +12%", "contrast: +8%", "saturation: +15%", "filter: Vintage"],
      "type": "filter",
    },
    {
      "id": "state_5",
      "title": "Crop & Resize",
      "description": "Cropped to 4:3 ratio",
      "timestamp": DateTime.now().subtract(Duration(minutes: 5)),
      "thumbnail": "https://picsum.photos/200/150?random=6",
      "changes": ["brightness: +12%", "contrast: +8%", "saturation: +15%", "filter: Vintage", "crop: 4:3"],
      "type": "transform",
    },
    {
      "id": "state_6",
      "title": "Text Overlay",
      "description": "Added watermark text",
      "timestamp": DateTime.now().subtract(Duration(minutes: 3)),
      "thumbnail": "https://picsum.photos/200/150?random=7",
      "changes": ["brightness: +12%", "contrast: +8%", "saturation: +15%", "filter: Vintage", "crop: 4:3", "text: watermark"],
      "type": "overlay",
    },
    {
      "id": "state_7",
      "title": "Shadow Effect",
      "description": "Added drop shadow",
      "timestamp": DateTime.now().subtract(Duration(minutes: 1)),
      "thumbnail": "https://picsum.photos/200/150?random=8",
      "changes": ["brightness: +12%", "contrast: +8%", "saturation: +15%", "filter: Vintage", "crop: 4:3", "text: watermark", "shadow: drop"],
      "type": "effect",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Undo & Redo"),
        actions: [
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {
              _showSettings();
            },
          ),
          QButton(
            icon: Icons.clear_all,
            size: bs.sm,
            onPressed: () {
              _clearHistory();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Control Bar
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              spacing: spSm,
              children: [
                // Undo Button
                QButton(
                  icon: Icons.undo,
                  size: bs.sm,
                  onPressed: currentStateIndex > 0 ? () {
                    _undoAction();
                  } : null,
                ),
                // Redo Button
                QButton(
                  icon: Icons.redo,
                  size: bs.sm,
                  onPressed: currentStateIndex < historyStates.length - 1 ? () {
                    _redoAction();
                  } : null,
                ),
                Spacer(),
                // Current State Info
                Text(
                  "Step ${currentStateIndex + 1} of ${historyStates.length}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                // Toggle Thumbnails
                QButton(
                  icon: showThumbnails ? Icons.grid_view : Icons.list,
                  size: bs.sm,
                  onPressed: () {
                    showThumbnails = !showThumbnails;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Current Image Preview
          Container(
            height: 300,
            margin: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusMd),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "${historyStates[currentStateIndex]["thumbnail"]}",
                    fit: BoxFit.cover,
                  ),
                  // Current State Overlay
                  Positioned(
                    top: spSm,
                    left: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(180),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${historyStates[currentStateIndex]["title"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // State Navigation Buttons
                  Positioned(
                    bottom: spSm,
                    left: spSm,
                    right: spSm,
                    child: Row(
                      spacing: spSm,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(128),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            spacing: spXs,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: currentStateIndex > 0 ? () {
                                  _gotoPreviousState();
                                } : null,
                                icon: Icon(
                                  Icons.skip_previous,
                                  color: currentStateIndex > 0 ? Colors.white : Colors.white54,
                                ),
                              ),
                              IconButton(
                                onPressed: currentStateIndex < historyStates.length - 1 ? () {
                                  _gotoNextState();
                                } : null,
                                icon: Icon(
                                  Icons.skip_next,
                                  color: currentStateIndex < historyStates.length - 1 ? Colors.white : Colors.white54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // History List
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border(top: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: showThumbnails ? _buildThumbnailHistory() : _buildListHistory(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnailHistory() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spSm),
      child: ResponsiveGridView(
        padding: EdgeInsets.zero,
        minItemWidth: 150,
        children: historyStates.asMap().entries.map((entry) {
          final index = entry.key;
          final state = entry.value;
          final isCurrent = index == currentStateIndex;
          final isPast = index < currentStateIndex;
          final isFuture = index > currentStateIndex;
          
          return GestureDetector(
            onTap: () {
              _gotoState(index);
            },
            child: Container(
              margin: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: isCurrent ? primaryColor.withAlpha(32) : Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: isCurrent ? primaryColor : 
                         isPast ? successColor : 
                         isFuture ? disabledOutlineBorderColor : disabledOutlineBorderColor,
                  width: isCurrent ? 2 : 1,
                ),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spXs,
                children: [
                  // Thumbnail
                  Container(
                    height: 100,
                    margin: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusXs),
                      image: DecorationImage(
                        image: NetworkImage("${state["thumbnail"]}"),
                        fit: BoxFit.cover,
                        colorFilter: isFuture ? ColorFilter.mode(
                          Colors.grey,
                          BlendMode.saturation,
                        ) : null,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // State Index
                        Positioned(
                          top: spXs,
                          left: spXs,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: isCurrent ? primaryColor : 
                                     isPast ? successColor : 
                                     isFuture ? disabledColor : disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Center(
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // State Type Icon
                        Positioned(
                          top: spXs,
                          right: spXs,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(128),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              _getStateIcon(state["type"] as String),
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // State Info
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: spXs),
                    child: Column(
                      spacing: 2,
                      children: [
                        Text(
                          "${state["title"]}",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: isCurrent ? primaryColor : disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${(state["timestamp"] as DateTime).dMMMy}",
                          style: TextStyle(
                            fontSize: 9,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spXs),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildListHistory() {
    return ListView.builder(
      padding: EdgeInsets.all(spSm),
      itemCount: historyStates.length,
      itemBuilder: (context, index) {
        final state = historyStates[index];
        final isCurrent = index == currentStateIndex;
        final isPast = index < currentStateIndex;
        final isFuture = index > currentStateIndex;
        
        return Container(
          margin: EdgeInsets.only(bottom: spXs),
          child: GestureDetector(
            onTap: () {
              _gotoState(index);
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isCurrent ? primaryColor.withAlpha(32) : Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: isCurrent ? primaryColor : 
                         isPast ? successColor : 
                         isFuture ? disabledOutlineBorderColor : disabledOutlineBorderColor,
                ),
                boxShadow: [shadowSm],
              ),
              child: Row(
                spacing: spSm,
                children: [
                  // State Index & Icon
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isCurrent ? primaryColor : 
                             isPast ? successColor : 
                             isFuture ? disabledColor : disabledColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Icon(
                            _getStateIcon(state["type"] as String),
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Thumbnail
                  Container(
                    width: 50,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusXs),
                      image: DecorationImage(
                        image: NetworkImage("${state["thumbnail"]}"),
                        fit: BoxFit.cover,
                        colorFilter: isFuture ? ColorFilter.mode(
                          Colors.grey,
                          BlendMode.saturation,
                        ) : null,
                      ),
                    ),
                  ),
                  // State Details
                  Expanded(
                    child: Column(
                      spacing: spXs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${state["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isCurrent ? primaryColor : disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${state["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${(state["timestamp"] as DateTime).dMMMy}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Actions
                  if (isCurrent) ...[
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {
                        _showStateOptions(state, index);
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  IconData _getStateIcon(String type) {
    switch (type) {
      case "import": return Icons.file_upload;
      case "adjustment": return Icons.tune;
      case "filter": return Icons.photo_filter;
      case "transform": return Icons.crop;
      case "overlay": return Icons.text_fields;
      case "effect": return Icons.auto_fix_high;
      default: return Icons.edit;
    }
  }

  void _undoAction() {
    if (currentStateIndex > 0) {
      currentStateIndex--;
      setState(() {});
      si("Undid last action");
    }
  }

  void _redoAction() {
    if (currentStateIndex < historyStates.length - 1) {
      currentStateIndex++;
      setState(() {});
      si("Redid action");
    }
  }

  void _gotoPreviousState() {
    if (currentStateIndex > 0) {
      currentStateIndex--;
      setState(() {});
    }
  }

  void _gotoNextState() {
    if (currentStateIndex < historyStates.length - 1) {
      currentStateIndex++;
      setState(() {});
    }
  }

  void _gotoState(int index) {
    currentStateIndex = index;
    setState(() {});
    si("Jumped to ${historyStates[index]["title"]}");
  }

  void _showSettings() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "History Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            // Auto Save Toggle
            Row(
              children: [
                Text(
                  "Auto Save States",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Switch(
                  value: autoSave,
                  onChanged: (value) {
                    autoSave = value;
                    setState(() {});
                  },
                ),
              ],
            ),
            // Max History States
            Row(
              children: [
                Text(
                  "Max History States",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "$maxHistoryStates",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            Slider(
              value: maxHistoryStates.toDouble(),
              min: 10,
              max: 50,
              divisions: 8,
              onChanged: (value) {
                maxHistoryStates = value.toInt();
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  void _clearHistory() async {
    bool isConfirmed = await confirm("Clear all history states except current?");
    if (isConfirmed) {
      ss("History cleared");
    }
  }

  void _showStateOptions(Map<String, dynamic> state, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "State Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ListTile(
              leading: Icon(Icons.bookmark_add),
              title: Text("Save as Preset"),
              onTap: () {
                back();
                _saveAsPreset(state);
              },
            ),
            ListTile(
              leading: Icon(Icons.copy),
              title: Text("Duplicate State"),
              onTap: () {
                back();
                _duplicateState(state);
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Share State"),
              onTap: () {
                back();
                _shareState(state);
              },
            ),
            if (index > 0)
              ListTile(
                leading: Icon(Icons.delete, color: dangerColor),
                title: Text("Delete State", style: TextStyle(color: dangerColor)),
                onTap: () {
                  back();
                  _deleteState(state, index);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _saveAsPreset(Map<String, dynamic> state) {
    ss("Saved ${state["title"]} as preset");
  }

  void _duplicateState(Map<String, dynamic> state) {
    ss("Duplicated ${state["title"]}");
  }

  void _shareState(Map<String, dynamic> state) {
    ss("Sharing ${state["title"]}");
  }

  void _deleteState(Map<String, dynamic> state, int index) async {
    bool isConfirmed = await confirm("Delete ${state["title"]}?");
    if (isConfirmed) {
      ss("Deleted ${state["title"]}");
    }
  }
}
