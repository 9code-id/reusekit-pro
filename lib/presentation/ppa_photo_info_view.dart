import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaPhotoInfoView extends StatefulWidget {
  const PpaPhotoInfoView({super.key});

  @override
  State<PpaPhotoInfoView> createState() => _PpaPhotoInfoViewState();
}

class _PpaPhotoInfoViewState extends State<PpaPhotoInfoView> {
  Map<String, dynamic> photoData = {
    "fileName": "IMG_20240615_142230.jpg",
    "filePath": "/storage/emulated/0/DCIM/Camera/IMG_20240615_142230.jpg",
    "fileSize": "2.4 MB",
    "dimensions": "3024 x 4032",
    "dateTaken": "June 15, 2024",
    "camera": "Google Pixel 7",
    "focal": "26mm",
    "aperture": "f/1.85",
    "iso": "ISO 64",
    "shutter": "1/120s",
    "flash": "No Flash",
    "gps": "37.7749° N, 122.4194° W",
    "location": "San Francisco, CA",
    "colorSpace": "sRGB",
    "resolution": "72 DPI",
    "orientation": "Portrait",
    "format": "JPEG",
    "compression": "85%",
    "histogram": {
      "red": [25, 45, 60, 75, 85, 90, 95, 100],
      "green": [30, 50, 65, 80, 90, 95, 98, 100],
      "blue": [20, 40, 55, 70, 80, 85, 90, 95]
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Information"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Photo info shared");
            },
          ),
          IconButton(
            icon: Icon(Icons.copy),
            onPressed: () {
              ss("Photo info copied to clipboard");
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
            // Photo Preview
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMd),
                image: DecorationImage(
                  image: NetworkImage("https://picsum.photos/400/500?random=1&keyword=photo"),
                  fit: BoxFit.cover,
                ),
                boxShadow: [shadowMd],
              ),
            ),

            // File Information
            _buildInfoSection(
              "File Information",
              [
                _buildInfoRow("File Name", "${photoData["fileName"]}"),
                _buildInfoRow("File Path", "${photoData["filePath"]}"),
                _buildInfoRow("File Size", "${photoData["fileSize"]}"),
                _buildInfoRow("Dimensions", "${photoData["dimensions"]}"),
                _buildInfoRow("Format", "${photoData["format"]}"),
                _buildInfoRow("Date Taken", "${photoData["dateTaken"]}"),
              ],
            ),

            // Camera Settings
            _buildInfoSection(
              "Camera Settings",
              [
                _buildInfoRow("Camera", "${photoData["camera"]}"),
                _buildInfoRow("Focal Length", "${photoData["focal"]}"),
                _buildInfoRow("Aperture", "${photoData["aperture"]}"),
                _buildInfoRow("ISO", "${photoData["iso"]}"),
                _buildInfoRow("Shutter Speed", "${photoData["shutter"]}"),
                _buildInfoRow("Flash", "${photoData["flash"]}"),
              ],
            ),

            // Location Information
            _buildInfoSection(
              "Location Information",
              [
                _buildInfoRow("GPS Coordinates", "${photoData["gps"]}"),
                _buildInfoRow("Location", "${photoData["location"]}"),
              ],
            ),

            // Technical Details
            _buildInfoSection(
              "Technical Details",
              [
                _buildInfoRow("Color Space", "${photoData["colorSpace"]}"),
                _buildInfoRow("Resolution", "${photoData["resolution"]}"),
                _buildInfoRow("Orientation", "${photoData["orientation"]}"),
                _buildInfoRow("Compression", "${photoData["compression"]}"),
              ],
            ),

            // Histogram
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Color Histogram",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    height: 150,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Red histogram
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Red",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: spXs),
                              ...(photoData["histogram"]["red"] as List).map((value) => 
                                Container(
                                  width: 8,
                                  height: (value as int).toDouble(),
                                  margin: EdgeInsets.only(bottom: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withAlpha(150),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        // Green histogram
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Green",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: spXs),
                              ...(photoData["histogram"]["green"] as List).map((value) => 
                                Container(
                                  width: 8,
                                  height: (value as int).toDouble(),
                                  margin: EdgeInsets.only(bottom: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withAlpha(150),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        // Blue histogram
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Blue",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: spXs),
                              ...(photoData["histogram"]["blue"] as List).map((value) => 
                                Container(
                                  width: 8,
                                  height: (value as int).toDouble(),
                                  margin: EdgeInsets.only(bottom: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withAlpha(150),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
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
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
