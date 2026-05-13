import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaDiseaseDetectionView extends StatefulWidget {
  const AmaDiseaseDetectionView({super.key});

  @override
  State<AmaDiseaseDetectionView> createState() => _AmaDiseaseDetectionViewState();
}

class _AmaDiseaseDetectionViewState extends State<AmaDiseaseDetectionView> {
  String selectedImage = "";
  String selectedCrop = "";
  String diseaseResults = "";
  bool isAnalyzing = false;
  String searchQuery = "";
  
  List<Map<String, dynamic>> cropTypes = [
    {"label": "Rice", "value": "rice"},
    {"label": "Wheat", "value": "wheat"},
    {"label": "Corn", "value": "corn"},
    {"label": "Tomato", "value": "tomato"},
    {"label": "Potato", "value": "potato"},
    {"label": "Soybean", "value": "soybean"},
  ];

  List<Map<String, dynamic>> recentDetections = [
    {
      "id": "1",
      "crop": "Tomato",
      "disease": "Late Blight",
      "severity": "High",
      "confidence": 92.5,
      "date": "2025-06-14",
      "image": "https://picsum.photos/150/150?random=1&keyword=tomato",
      "treatment": "Apply copper-based fungicide immediately",
      "status": "Critical"
    },
    {
      "id": "2", 
      "crop": "Rice",
      "disease": "Bacterial Leaf Blight",
      "severity": "Medium",
      "confidence": 87.3,
      "date": "2025-06-13",
      "image": "https://picsum.photos/150/150?random=2&keyword=rice",
      "treatment": "Reduce nitrogen fertilizer and improve drainage",
      "status": "Moderate"
    },
    {
      "id": "3",
      "crop": "Wheat",
      "disease": "Rust Disease",
      "severity": "Low",
      "confidence": 78.9,
      "date": "2025-06-12",
      "image": "https://picsum.photos/150/150?random=3&keyword=wheat",
      "treatment": "Monitor closely and apply preventive spray",
      "status": "Watch"
    },
    {
      "id": "4",
      "crop": "Corn",
      "disease": "Corn Smut",
      "severity": "Medium",
      "confidence": 85.2,
      "date": "2025-06-11",
      "image": "https://picsum.photos/150/150?random=4&keyword=corn",
      "treatment": "Remove infected plants and improve air circulation",
      "status": "Moderate"
    },
  ];

  List<Map<String, dynamic>> diseaseLibrary = [
    {
      "name": "Late Blight",
      "crops": ["Tomato", "Potato"],
      "symptoms": "Dark spots on leaves, white mold on undersides",
      "causes": "High humidity and moderate temperatures",
      "prevention": "Proper spacing, avoid overhead watering",
      "treatment": "Copper-based fungicides, remove infected plants"
    },
    {
      "name": "Bacterial Leaf Blight",
      "crops": ["Rice"],
      "symptoms": "Yellow to white lesions on leaf edges",
      "causes": "Bacterial infection in warm, humid conditions",
      "prevention": "Use resistant varieties, proper field sanitation",
      "treatment": "Copper bactericides, reduce nitrogen"
    },
    {
      "name": "Rust Disease",
      "crops": ["Wheat", "Corn"],
      "symptoms": "Orange-red pustules on leaves and stems",
      "causes": "Fungal spores in cool, moist conditions",
      "prevention": "Crop rotation, resistant varieties",
      "treatment": "Fungicide application, remove crop residue"
    },
  ];

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
      case 'critical':
        return dangerColor;
      case 'medium':
      case 'moderate':
        return warningColor;
      case 'low':
      case 'watch':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _startAnalysis() async {
    if (selectedImage.isEmpty) {
      se("Please select an image first");
      return;
    }
    
    isAnalyzing = true;
    setState(() {});
    
    // Simulate AI analysis
    await Future.delayed(Duration(seconds: 3));
    
    diseaseResults = "Analysis Complete";
    isAnalyzing = false;
    setState(() {});
    
    ss("Disease detection completed successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Disease Detection"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // AI Detection Card
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
                  Row(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "AI Disease Detection",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Upload a photo of your crop to detect diseases using AI technology",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Select Crop Type",
                    items: cropTypes,
                    value: selectedCrop,
                    onChanged: (value, label) {
                      selectedCrop = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QImagePicker(
                    label: "Upload Crop Image",
                    value: selectedImage,
                    hint: "Take a photo or select from gallery",
                    onChanged: (value) {
                      selectedImage = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),
                  if (isAnalyzing)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.blue.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: Colors.blue.withAlpha(40)),
                      ),
                      child: Column(
                        children: [
                          CircularProgressIndicator(color: primaryColor),
                          SizedBox(height: spSm),
                          Text(
                            "Analyzing image with AI...",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "This may take a few moments",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Start Analysis",
                        size: bs.md,
                        onPressed: _startAnalysis,
                      ),
                    ),
                ],
              ),
            ),

            // Recent Detections
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
                  Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Recent Detections",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...recentDetections.take(3).map((detection) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${detection["image"]}",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${detection["disease"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getSeverityColor(detection["status"]),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${detection["status"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${detection["crop"]} • ${(detection["confidence"] as num).toStringAsFixed(1)}% confidence",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${detection["treatment"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spSm),
                          GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: disabledBoldColor,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Disease Library
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
                  Row(
                    children: [
                      Icon(
                        Icons.local_library,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Disease Library",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search diseases...",
                          value: searchQuery,
                          hint: "Enter disease name or crop",
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
                  ...diseaseLibrary.map((disease) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${disease["name"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  Icons.info_outline,
                                  color: primaryColor,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Affects: ${(disease["crops"] as List).join(", ")}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "${disease["symptoms"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 11,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Quick Tips
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Detection Tips",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Take clear, well-lit photos of affected plant parts\n• Include multiple angles if possible\n• Ensure the disease symptoms are clearly visible\n• Select the correct crop type for accurate detection",
                    style: TextStyle(
                      color: successColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
