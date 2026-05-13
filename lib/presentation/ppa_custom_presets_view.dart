import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaCustomPresetsView extends StatefulWidget {
  const PpaCustomPresetsView({super.key});

  @override
  State<PpaCustomPresetsView> createState() => _PpaCustomPresetsViewState();
}

class _PpaCustomPresetsViewState extends State<PpaCustomPresetsView> {
  List<Map<String, dynamic>> customPresets = [
    {
      "id": 1,
      "name": "My Golden Look",
      "dateCreated": "2024-01-15",
      "lastModified": "2024-01-20",
      "thumbnail": "https://picsum.photos/150/100?random=1&keyword=golden",
      "settings": {
        "brightness": 15,
        "contrast": 25,
        "saturation": 20,
        "highlights": -10,
        "shadows": 15,
        "vibrance": 30,
      },
      "tags": ["warm", "portrait", "golden"],
      "favorite": true,
      "timesUsed": 12,
    },
    {
      "id": 2,
      "name": "Cool Urban",
      "dateCreated": "2024-01-10",
      "lastModified": "2024-01-18",
      "thumbnail": "https://picsum.photos/150/100?random=2&keyword=urban",
      "settings": {
        "brightness": -5,
        "contrast": 30,
        "saturation": -10,
        "highlights": 20,
        "shadows": -15,
        "vibrance": 10,
      },
      "tags": ["cool", "urban", "modern"],
      "favorite": false,
      "timesUsed": 8,
    },
    {
      "id": 3,
      "name": "Vintage Film",
      "dateCreated": "2024-01-08",
      "lastModified": "2024-01-12",
      "thumbnail": "https://picsum.photos/150/100?random=3&keyword=vintage",
      "settings": {
        "brightness": 10,
        "contrast": 15,
        "saturation": -20,
        "highlights": -20,
        "shadows": 25,
        "vibrance": -10,
      },
      "tags": ["vintage", "film", "retro"],
      "favorite": true,
      "timesUsed": 15,
    },
  ];

  String searchQuery = "";
  String sortBy = "recent";
  bool showOnlyFavorites = false;
  bool isCreatingPreset = false;

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Most Recent", "value": "recent"},
    {"label": "Most Used", "value": "usage"},
    {"label": "Name A-Z", "value": "name"},
    {"label": "Favorites First", "value": "favorites"},
  ];

  // Current editing settings for new preset
  String newPresetName = "";
  Map<String, double> currentSettings = {
    "brightness": 0,
    "contrast": 0,
    "saturation": 0,
    "highlights": 0,
    "shadows": 0,
    "vibrance": 0,
    "clarity": 0,
    "warmth": 0,
    "tint": 0,
  };
  List<String> currentTags = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Presets"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _startCreatingPreset();
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              _showSortOptions();
            },
          ),
        ],
      ),
      body: isCreatingPreset ? _buildCreatePresetView() : _buildPresetsListView(),
    );
  }

  Widget _buildPresetsListView() {
    return Column(
      children: [
        // Search and Filter Bar
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: disabledBoldColor),
                          SizedBox(width: spSm),
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                searchQuery = value;
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                hintText: "Search custom presets...",
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: disabledBoldColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  GestureDetector(
                    onTap: () {
                      showOnlyFavorites = !showOnlyFavorites;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: showOnlyFavorites ? dangerColor : Colors.grey[200],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: showOnlyFavorites ? Colors.white : disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "${_getFilteredPresets().length} presets",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Sort: ${sortOptions.firstWhere((s) => s["value"] == sortBy)["label"]}",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Presets Grid
        Expanded(
          child: _getFilteredPresets().isEmpty
            ? _buildEmptyState()
            : ResponsiveGridView(
                padding: EdgeInsets.all(spMd),
                minItemWidth: 200,
                children: _getFilteredPresets().map((preset) {
                  return _buildCustomPresetCard(preset);
                }).toList(),
              ),
        ),
      ],
    );
  }

  Widget _buildCreatePresetView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spLg,
        children: [
          // Header
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  isCreatingPreset = false;
                  setState(() {});
                },
              ),
              Expanded(
                child: Text(
                  "Create Custom Preset",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),

          // Preview Image
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusMd),
              image: DecorationImage(
                image: NetworkImage("https://picsum.photos/400/200?random=10&keyword=editing"),
                fit: BoxFit.cover,
              ),
              boxShadow: [shadowSm],
            ),
            child: Stack(
              children: [
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Live Preview",
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

          // Preset Name
          Text(
            "Preset Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                TextField(
                  onChanged: (value) {
                    newPresetName = value;
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    labelText: "Preset Name",
                    hintText: "Enter a descriptive name",
                    border: OutlineInputBorder(),
                  ),
                ),
                // Tags input (simplified)
                TextField(
                  onChanged: (value) {
                    currentTags = value.split(',').map((tag) => tag.trim()).toList();
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    labelText: "Tags (comma separated)",
                    hintText: "portrait, warm, vintage",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),

          // Adjustment Settings
          Text(
            "Adjustments",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: currentSettings.keys.map((setting) {
                return _buildAdjustmentSlider(
                  setting.replaceAll(RegExp(r'([A-Z])'), r' \$1').toLowerCase().split(' ').map((word) => word[0].toUpperCase() + word.substring(1)).join(' '),
                  currentSettings[setting]!,
                  -100.0,
                  100.0,
                  (value) {
                    currentSettings[setting] = value;
                    setState(() {});
                  },
                );
              }).toList(),
            ),
          ),

          // Action Buttons
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  color: dangerColor,
                  size: bs.md,
                  onPressed: () {
                    isCreatingPreset = false;
                    _resetNewPreset();
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Save Preset",
                  size: bs.md,
                  onPressed: newPresetName.isNotEmpty ? () {
                    _saveCustomPreset();
                  } : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomPresetCard(Map<String, dynamic> preset) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusSm),
                    topRight: Radius.circular(radiusSm),
                  ),
                  image: DecorationImage(
                    image: NetworkImage("${preset["thumbnail"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              // Favorite indicator
              if (preset["favorite"])
                Positioned(
                  top: spXs,
                  right: spXs,
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),

              // Usage count
              Positioned(
                bottom: spXs,
                left: spXs,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "Used ${preset["timesUsed"]}x",
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

          // Content
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${preset["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                Text(
                  "Modified: ${preset["lastModified"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),

                if ((preset["tags"] as List).isNotEmpty)
                  Wrap(
                    spacing: spXs,
                    children: (preset["tags"] as List).take(2).map((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$tag",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                SizedBox(height: spXs),
                
                Row(
                  spacing: spXs,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Apply",
                        size: bs.sm,
                        onPressed: () {
                          _applyCustomPreset(preset);
                        },
                      ),
                    ),
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () {
                        _editPreset(preset);
                      },
                    ),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {
                        _showPresetOptions(preset);
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

  Widget _buildAdjustmentSlider(
    String label,
    double value,
    double min,
    double max,
    Function(double) onChanged,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Text(
              "${value >= 0 ? '+' : ''}${value.toInt()}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: 200,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.palette,
            size: 80,
            color: disabledBoldColor,
          ),
          SizedBox(height: spMd),
          Text(
            "No Custom Presets",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Create your first custom preset\nto save your favorite settings",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spLg),
          QButton(
            label: "Create Preset",
            icon: Icons.add,
            size: bs.md,
            onPressed: () {
              _startCreatingPreset();
            },
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredPresets() {
    var filtered = customPresets.where((preset) {
      bool matchesSearch = searchQuery.isEmpty || 
                          (preset["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
                          (preset["tags"] as List).any((tag) => tag.toString().toLowerCase().contains(searchQuery.toLowerCase()));
      bool matchesFavorites = !showOnlyFavorites || preset["favorite"] == true;
      
      return matchesSearch && matchesFavorites;
    }).toList();

    // Sort presets
    switch (sortBy) {
      case "recent":
        filtered.sort((a, b) => b["lastModified"].compareTo(a["lastModified"]));
        break;
      case "usage":
        filtered.sort((a, b) => (b["timesUsed"] as int) - (a["timesUsed"] as int));
        break;
      case "name":
        filtered.sort((a, b) => (a["name"] as String).compareTo(b["name"] as String));
        break;
      case "favorites":
        filtered.sort((a, b) {
          if (a["favorite"] && !b["favorite"]) return -1;
          if (!a["favorite"] && b["favorite"]) return 1;
          return b["lastModified"].compareTo(a["lastModified"]);
        });
        break;
    }

    return filtered;
  }

  void _startCreatingPreset() {
    isCreatingPreset = true;
    _resetNewPreset();
    setState(() {});
  }

  void _resetNewPreset() {
    newPresetName = "";
    currentTags = [];
    currentSettings = {
      "brightness": 0,
      "contrast": 0,
      "saturation": 0,
      "highlights": 0,
      "shadows": 0,
      "vibrance": 0,
      "clarity": 0,
      "warmth": 0,
      "tint": 0,
    };
  }

  void _saveCustomPreset() {
    final newId = customPresets.map((p) => p["id"] as int).fold(0, (max, id) => id > max ? id : max) + 1;
    
    customPresets.insert(0, {
      "id": newId,
      "name": newPresetName,
      "dateCreated": DateTime.now().toString().substring(0, 10),
      "lastModified": DateTime.now().toString().substring(0, 10),
      "thumbnail": "https://picsum.photos/150/100?random=$newId&keyword=custom",
      "settings": Map<String, double>.from(currentSettings),
      "tags": List<String>.from(currentTags),
      "favorite": false,
      "timesUsed": 0,
    });

    isCreatingPreset = false;
    setState(() {});
    ss("Custom preset '$newPresetName' saved successfully");
  }

  void _applyCustomPreset(Map<String, dynamic> preset) {
    // Increment usage count
    preset["timesUsed"] = (preset["timesUsed"] as int) + 1;
    preset["lastModified"] = DateTime.now().toString().substring(0, 10);
    setState(() {});
    
    ss("Applied preset: ${preset["name"]}");
  }

  void _editPreset(Map<String, dynamic> preset) {
    // Load preset settings into editor
    newPresetName = preset["name"];
    currentSettings = Map<String, double>.from(preset["settings"]);
    currentTags = List<String>.from(preset["tags"]);
    isCreatingPreset = true;
    setState(() {});
  }

  void _showPresetOptions(Map<String, dynamic> preset) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(preset["favorite"] ? Icons.favorite : Icons.favorite_border),
              title: Text(preset["favorite"] ? "Remove from Favorites" : "Add to Favorites"),
              onTap: () {
                preset["favorite"] = !preset["favorite"];
                setState(() {});
                back();
                si(preset["favorite"] ? "Added to favorites" : "Removed from favorites");
              },
            ),
            ListTile(
              leading: Icon(Icons.copy),
              title: Text("Duplicate"),
              onTap: () {
                back();
                _duplicatePreset(preset);
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Export"),
              onTap: () {
                back();
                si("Exporting preset...");
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete", style: TextStyle(color: dangerColor)),
              onTap: () {
                back();
                _deletePreset(preset["id"]);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _duplicatePreset(Map<String, dynamic> preset) {
    final newId = customPresets.map((p) => p["id"] as int).fold(0, (max, id) => id > max ? id : max) + 1;
    final duplicated = Map<String, dynamic>.from(preset);
    duplicated["id"] = newId;
    duplicated["name"] = "${preset["name"]} Copy";
    duplicated["dateCreated"] = DateTime.now().toString().substring(0, 10);
    duplicated["lastModified"] = DateTime.now().toString().substring(0, 10);
    duplicated["timesUsed"] = 0;
    duplicated["favorite"] = false;

    customPresets.insert(0, duplicated);
    setState(() {});
    ss("Preset duplicated");
  }

  void _deletePreset(int presetId) {
    customPresets.removeWhere((preset) => preset["id"] == presetId);
    setState(() {});
    ss("Preset deleted");
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sort By",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...sortOptions.map((option) {
              bool isSelected = sortBy == option["value"];
              return ListTile(
                leading: Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                  color: isSelected ? primaryColor : disabledBoldColor,
                ),
                title: Text("${option["label"]}"),
                onTap: () {
                  sortBy = option["value"];
                  setState(() {});
                  back();
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
