import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlGallery7View extends StatefulWidget {
  @override
  State<GrlGallery7View> createState() => _GrlGallery7ViewState();
}

class _GrlGallery7ViewState extends State<GrlGallery7View> {
  String albumName = "";
  String albumDescription = "";
  String selectedPrivacy = "Public";
  List<String> uploadedImages = [];
  bool loading = false;

  final List<Map<String, dynamic>> privacyOptions = [
    {"label": "Public", "value": "Public"},
    {"label": "Private", "value": "Private"},
    {"label": "Friends Only", "value": "Friends Only"},
  ];

  final List<Map<String, dynamic>> suggestedImages = [
    {
      "url": "https://picsum.photos/300/400?random=90&keyword=nature",
      "selected": false,
    },
    {
      "url": "https://picsum.photos/300/400?random=91&keyword=city",
      "selected": false,
    },
    {
      "url": "https://picsum.photos/300/400?random=92&keyword=food",
      "selected": false,
    },
    {
      "url": "https://picsum.photos/300/400?random=93&keyword=travel",
      "selected": false,
    },
    {
      "url": "https://picsum.photos/300/400?random=94&keyword=art",
      "selected": false,
    },
    {
      "url": "https://picsum.photos/300/400?random=95&keyword=people",
      "selected": false,
    },
  ];

  final formKey = GlobalKey<FormState>();

  List<String> get selectedImages {
    return suggestedImages
        .where((img) => img["selected"] == true)
        .map((img) => img["url"] as String)
        .toList();
  }

  void _toggleImageSelection(int index) {
    suggestedImages[index]["selected"] = !(suggestedImages[index]["selected"] as bool);
    setState(() {});
  }

  void _createAlbum() async {
    if (formKey.currentState!.validate()) {
      if (uploadedImages.isEmpty && selectedImages.isEmpty) {
        se("Please add at least one image to create an album");
        return;
      }

      loading = true;
      setState(() {});

      // Simulate album creation
      await Future.delayed(Duration(seconds: 3));

      loading = false;
      setState(() {});

      ss("Album '$albumName' created successfully!");
      
      // Reset form
      albumName = "";
      albumDescription = "";
      selectedPrivacy = "Public";
      uploadedImages.clear();
      for (var img in suggestedImages) {
        img["selected"] = false;
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Album"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Need help? Check our album creation guide!");
            },
          ),
        ],
      ),
      body: loading
          ? Center(
              child: Column(
                spacing: spMd,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text(
                    "Creating your album...",
                    style: TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              Icons.photo_library,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Create New Album",
                                  style: TextStyle(
                                    fontSize: fsH4,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Organize your photos into beautiful collections",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Album Details Section
                    Text(
                      "Album Details",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    QTextField(
                      label: "Album Name",
                      value: albumName,
                      hint: "Enter a name for your album",
                      validator: Validator.required,
                      onChanged: (value) {
                        albumName = value;
                        setState(() {});
                      },
                    ),

                    QMemoField(
                      label: "Description",
                      value: albumDescription,
                      hint: "Describe what this album is about (optional)",
                      onChanged: (value) {
                        albumDescription = value;
                        setState(() {});
                      },
                    ),

                    QDropdownField(
                      label: "Privacy Setting",
                      items: privacyOptions,
                      value: selectedPrivacy,
                      onChanged: (value, label) {
                        selectedPrivacy = value;
                        setState(() {});
                      },
                    ),

                    // Privacy Info
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(color: infoColor.withAlpha(30)),
                      ),
                      child: Column(
                        spacing: spSm,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                _getPrivacyIcon(selectedPrivacy),
                                size: 20,
                                color: infoColor,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "$selectedPrivacy Album",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            _getPrivacyDescription(selectedPrivacy),
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Upload Images Section
                    Text(
                      "Add Images",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    QMultiImagePicker(
                      label: "Upload Images",
                      value: uploadedImages,
                      maxImages: 20,
                      hint: "Select up to 20 images for your album",
                      onChanged: (value) {
                        uploadedImages = value;
                        setState(() {});
                      },
                    ),

                    // Divider
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: spMd),
                          child: Text(
                            "OR",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),

                    // Suggested Images Section
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Choose from Suggested",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        if (selectedImages.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${selectedImages.length} selected",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),

                    Text(
                      "Select from our curated collection of high-quality images",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),

                    // Suggested Images Grid
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: List.generate(suggestedImages.length, (index) {
                        final image = suggestedImages[index];
                        final isSelected = image["selected"] as bool;
                        
                        return GestureDetector(
                          onTap: () => _toggleImageSelection(index),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledColor,
                                width: isSelected ? 2 : 1,
                              ),
                              boxShadow: isSelected ? [shadowMd] : [shadowSm],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Stack(
                                children: [
                                  Image.network(
                                    "${image["url"]}",
                                    width: double.infinity,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),

                                  // Selection Overlay
                                  if (isSelected)
                                    Positioned.fill(
                                      child: Container(
                                        color: primaryColor.withAlpha(50),
                                      ),
                                    ),

                                  // Selection Checkbox
                                  Positioned(
                                    top: spSm,
                                    right: spSm,
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: isSelected ? primaryColor : Colors.white,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                        border: Border.all(
                                          color: isSelected ? primaryColor : disabledColor,
                                          width: 2,
                                        ),
                                      ),
                                      child: isSelected
                                          ? Icon(
                                              Icons.check,
                                              size: 16,
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),

                    // Selection Actions
                    if (selectedImages.isNotEmpty || uploadedImages.isNotEmpty)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(color: successColor.withAlpha(30)),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: successColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${uploadedImages.length + selectedImages.length} images ready for album",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: successColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (uploadedImages.isNotEmpty)
                              Text(
                                "• ${uploadedImages.length} uploaded images",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            if (selectedImages.isNotEmpty)
                              Text(
                                "• ${selectedImages.length} selected from suggestions",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                          ],
                        ),
                      ),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Preview Album",
                            size: bs.md,
                            onPressed: () {
                              if (albumName.isEmpty) {
                                se("Please enter an album name first");
                                return;
                              }
                              si("Album preview feature coming soon!");
                            },
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          flex: 2,
                          child: QButton(
                            label: "Create Album",
                            icon: Icons.create,
                            size: bs.md,
                            onPressed: _createAlbum,
                          ),
                        ),
                      ],
                    ),

                    // Tips Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(color: warningColor.withAlpha(30)),
                      ),
                      child: Column(
                        spacing: spSm,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.lightbulb_outline,
                                size: 20,
                                color: warningColor,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Album Creation Tips",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "• Choose a descriptive name for easy discovery\n• Add 3-20 images for the best viewing experience\n• Use public albums to share with the community\n• Private albums are only visible to you",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  IconData _getPrivacyIcon(String privacy) {
    switch (privacy) {
      case "Public":
        return Icons.public;
      case "Private":
        return Icons.lock;
      case "Friends Only":
        return Icons.group;
      default:
        return Icons.public;
    }
  }

  String _getPrivacyDescription(String privacy) {
    switch (privacy) {
      case "Public":
        return "Anyone can view this album and discover it in search results";
      case "Private":
        return "Only you can view this album. It won't appear in search results";
      case "Friends Only":
        return "Only your friends can view this album";
      default:
        return "";
    }
  }
}
