import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsPhotoUploadView extends StatefulWidget {
  const BrsPhotoUploadView({super.key});

  @override
  State<BrsPhotoUploadView> createState() => _BrsPhotoUploadViewState();
}

class _BrsPhotoUploadViewState extends State<BrsPhotoUploadView> {
  List<String> uploadedPhotos = [];
  String selectedCategory = "Haircut";
  String description = "";
  bool isPublic = true;

  List<Map<String, dynamic>> photoCategories = [
    {"label": "Haircut", "value": "Haircut"},
    {"label": "Beard Styling", "value": "Beard Styling"},
    {"label": "Hair Color", "value": "Hair Color"},
    {"label": "Styling", "value": "Styling"},
    {"label": "Treatment", "value": "Treatment"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Photos"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () {
              _savePhotos();
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Photo Upload Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Upload Photos",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Share your haircut experience and inspire others",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                  QMultiImagePicker(
                    label: "Select Photos",
                    value: uploadedPhotos,
                    maxImages: 8,
                    hint: "Upload your haircut photos",
                    validator: Validator.required,
                    helper:
                        "You can upload up to 8 photos to showcase your style",
                    onChanged: (images) {
                      uploadedPhotos = images;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Photo Gallery Preview
            if (uploadedPhotos.isNotEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Photo Preview",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    QHorizontalScroll(
                      children: List.generate(uploadedPhotos.length, (index) {
                        return Container(
                          width: 150,
                          height: 150,
                          margin: EdgeInsets.only(
                            right: index < uploadedPhotos.length - 1 ? spSm : 0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusMd),
                            image: DecorationImage(
                              image: NetworkImage("${uploadedPhotos[index]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusMd),
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.black.withAlpha(100),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.all(spXs),
                                child: GestureDetector(
                                  onTap: () {
                                    uploadedPhotos.removeAt(index);
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),

            // Photo Details Form
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Photo Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  QDropdownField(
                    label: "Category",
                    items: photoCategories,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                  QMemoField(
                    label: "Description",
                    value: description,
                    hint:
                        "Describe your experience, style details, or any tips...",
                    onChanged: (value) {
                      description = value;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    label: "Privacy Settings",
                    items: [
                      {
                        "label": "Make photos public",
                        "value": true,
                        "checked": isPublic,
                      }
                    ],
                    value: [
                      if (isPublic)
                        {
                          "label": "Make photos public",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      isPublic = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Upload Tips
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Photo Tips",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Take photos in good lighting for best results\n• Include before and after shots when possible\n• Show different angles of your haircut\n• Keep photos clear and well-focused\n• Respect privacy - only upload with consent",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Recent Uploads
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Recent Uploads",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 120,
                    children: List.generate(6, (index) {
                      return Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusSm),
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://picsum.photos/120/120?random=${index + 20}&keyword=haircut"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withAlpha(150),
                              ],
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.all(spXs),
                              child: Text(
                                "${DateTime.now().subtract(Duration(days: index)).day}/${DateTime.now().month}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _savePhotos() {
    if (uploadedPhotos.isEmpty) {
      se("Please select at least one photo");
      return;
    }

    if (description.isEmpty) {
      se("Please add a description");
      return;
    }

    ss("Photos uploaded successfully!");
    back();
  }
}
