import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaSavePresetView extends StatefulWidget {
  const PpaSavePresetView({super.key});

  @override
  State<PpaSavePresetView> createState() => _PpaSavePresetViewState();
}

class _PpaSavePresetViewState extends State<PpaSavePresetView> {
  String presetName = "";
  String presetDescription = "";
  String selectedCategory = "general";
  List<String> selectedTags = [];
  String presetImage = "https://picsum.photos/400/400?random=1";
  bool saveToCloud = true;
  bool makePublic = false;
  bool includeMetadata = true;

  final List<Map<String, dynamic>> categories = [
    {"label": "General", "value": "general", "icon": Icons.photo_filter},
    {"label": "Portrait", "value": "portrait", "icon": Icons.person},
    {"label": "Landscape", "value": "landscape", "icon": Icons.landscape},
    {"label": "Street", "value": "street", "icon": Icons.location_city},
    {"label": "Food", "value": "food", "icon": Icons.restaurant},
    {"label": "Black & White", "value": "black_white", "icon": Icons.monochrome_photos},
    {"label": "Cinematic", "value": "cinematic", "icon": Icons.movie},
    {"label": "Vintage", "value": "vintage", "icon": Icons.history},
  ];

  final List<String> availableTags = [
    "dramatic", "soft", "warm", "cool", "bright", "dark", "moody", "clean",
    "vintage", "modern", "natural", "artistic", "commercial", "social", 
    "professional", "casual", "wedding", "travel", "nature", "urban"
  ];

  // Sample current adjustments
  final Map<String, dynamic> currentAdjustments = {
    "exposure": "+0.3",
    "contrast": "+0.2",
    "highlights": "-0.4",
    "shadows": "+0.3",
    "whites": "+0.1",
    "blacks": "-0.2",
    "clarity": "+0.15",
    "vibrance": "+0.25",
    "saturation": "+0.1",
    "warmth": "+0.2",
    "tint": "+0.05",
    "sharpness": "+0.1",
    "noise_reduction": "+0.1",
    "vignette": "+0.2",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Save Preset"),
        actions: [
          QButton(
            icon: Icons.help_outline,
            size: bs.sm,
            onPressed: () {
              _showHelp();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Preview Section
            Container(
              width: double.infinity,
              height: 200,
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
                      presetImage,
                      fit: BoxFit.cover,
                    ),
                    // Overlay Info
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withAlpha(180),
                            ],
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                spacing: spXs,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    presetName.isEmpty ? "Untitled Preset" : presetName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Preview with current adjustments",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            QButton(
                              icon: Icons.photo_camera,
                              size: bs.sm,
                              onPressed: () {
                                _changePreviewImage();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Basic Information
            Text(
              "Preset Information",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QTextField(
              label: "Preset Name",
              value: presetName,
              hint: "Enter a descriptive name for your preset",
              validator: Validator.required,
              onChanged: (value) {
                presetName = value;
                setState(() {});
              },
            ),
            QMemoField(
              label: "Description",
              value: presetDescription,
              hint: "Describe what this preset does and when to use it",
              onChanged: (value) {
                presetDescription = value;
                setState(() {});
              },
            ),

            // Category Selection
            Text(
              "Category",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category["value"];
                  
                  return Container(
                    width: 90,
                    margin: EdgeInsets.only(right: spSm),
                    child: GestureDetector(
                      onTap: () {
                        selectedCategory = category["value"] as String;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spXs,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              category["icon"],
                              color: isSelected ? Colors.white : primaryColor,
                              size: 28,
                            ),
                            Text(
                              "${category["label"]}",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : primaryColor,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Tags
            Text(
              "Tags",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "Select tags that describe your preset style",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: availableTags.map((tag) {
                final isSelected = selectedTags.contains(tag);
                return GestureDetector(
                  onTap: () {
                    if (isSelected) {
                      selectedTags.remove(tag);
                    } else {
                      selectedTags.add(tag);
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Text(
                      "#$tag",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : primaryColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            // Current Adjustments Summary
            Text(
              "Current Adjustments",
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
                spacing: spXs,
                children: [
                  Text(
                    "These adjustments will be saved in your preset:",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spXs,
                    children: currentAdjustments.entries.map((entry) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(16),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${entry.key}: ${entry.value}",
                          style: TextStyle(
                            fontSize: 10,
                            color: primaryColor,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Save Options
            Text(
              "Save Options",
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
                  // Save to Cloud
                  Row(
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        size: 20,
                        color: primaryColor,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Save to Cloud",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Sync across all your devices",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: saveToCloud,
                        onChanged: (value) {
                          saveToCloud = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  // Make Public
                  Row(
                    children: [
                      Icon(
                        Icons.public,
                        size: 20,
                        color: primaryColor,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Make Public",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Share with the community",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: makePublic,
                        onChanged: (value) {
                          makePublic = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  // Include Metadata
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        size: 20,
                        color: primaryColor,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Include Metadata",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Camera settings and edit history",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: includeMetadata,
                        onChanged: (value) {
                          includeMetadata = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Cancel",
                    size: bs.md,
                    onPressed: () {
                      back();
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: "Save Preset",
                    size: bs.md,
                    onPressed: () {
                      _savePreset();
                    },
                  ),
                ),
              ],
            ),

            // Quick Save Templates
            Text(
              "Quick Save Templates",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "Or use these preset templates with auto-filled information",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Portrait Style",
                    size: bs.sm,
                    onPressed: () {
                      _applyTemplate("portrait");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Landscape",
                    size: bs.sm,
                    onPressed: () {
                      _applyTemplate("landscape");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Cinematic",
                    size: bs.sm,
                    onPressed: () {
                      _applyTemplate("cinematic");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _changePreviewImage() {
    presetImage = "https://picsum.photos/400/400?random=${DateTime.now().millisecondsSinceEpoch}";
    setState(() {});
    si("Preview image changed");
  }

  void _showHelp() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Preset Help",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "• Give your preset a clear, descriptive name\n"
              "• Add tags to help others find your preset\n"
              "• Choose the right category for better organization\n"
              "• Preview image helps others understand the style\n"
              "• Public presets can be downloaded by other users",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _applyTemplate(String template) {
    switch (template) {
      case "portrait":
        presetName = "Portrait Enhancement";
        presetDescription = "Soft and flattering preset perfect for portrait photography";
        selectedCategory = "portrait";
        selectedTags = ["portrait", "soft", "natural", "professional"];
        break;
      case "landscape":
        presetName = "Landscape Vibrant";
        presetDescription = "Enhanced colors and contrast for stunning landscape photos";
        selectedCategory = "landscape";
        selectedTags = ["landscape", "vibrant", "nature", "dramatic"];
        break;
      case "cinematic":
        presetName = "Cinematic Mood";
        presetDescription = "Dark and moody preset with cinematic color grading";
        selectedCategory = "cinematic";
        selectedTags = ["cinematic", "moody", "dark", "dramatic"];
        break;
    }
    setState(() {});
    si("Applied $template template");
  }

  void _savePreset() {
    if (presetName.isEmpty) {
      se("Please enter a preset name");
      return;
    }

    showLoading();
    
    // Simulate save process
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Preset saved successfully!");
      back();
    });
  }
}
