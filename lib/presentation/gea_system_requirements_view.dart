import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaSystemRequirementsView extends StatefulWidget {
  const GeaSystemRequirementsView({super.key});

  @override
  State<GeaSystemRequirementsView> createState() => _GeaSystemRequirementsViewState();
}

class _GeaSystemRequirementsViewState extends State<GeaSystemRequirementsView> {
  List<Map<String, dynamic>> requirements = [
    {
      "category": "Minimum Requirements",
      "specs": [
        {"component": "OS", "requirement": "Windows 10 64-bit", "met": true},
        {"component": "Processor", "requirement": "Intel Core i3-6100 / AMD FX-6300", "met": true},
        {"component": "Memory", "requirement": "8 GB RAM", "met": true},
        {"component": "Graphics", "requirement": "NVIDIA GTX 1050 Ti / AMD RX 470", "met": false},
        {"component": "DirectX", "requirement": "Version 12", "met": true},
        {"component": "Storage", "requirement": "50 GB available space", "met": true},
        {"component": "Network", "requirement": "Broadband Internet connection", "met": true},
      ]
    },
    {
      "category": "Recommended Requirements",
      "specs": [
        {"component": "OS", "requirement": "Windows 11 64-bit", "met": false},
        {"component": "Processor", "requirement": "Intel Core i7-8700K / AMD Ryzen 5 3600", "met": false},
        {"component": "Memory", "requirement": "16 GB RAM", "met": false},
        {"component": "Graphics", "requirement": "NVIDIA RTX 3070 / AMD RX 6700 XT", "met": false},
        {"component": "DirectX", "requirement": "Version 12", "met": true},
        {"component": "Storage", "requirement": "100 GB available space (SSD)", "met": true},
        {"component": "Network", "requirement": "Broadband Internet connection", "met": true},
      ]
    }
  ];

  Map<String, dynamic> systemInfo = {
    "os": "Windows 10 Pro 64-bit",
    "processor": "Intel Core i5-9400F @ 2.90GHz",
    "memory": "8.00 GB",
    "graphics": "NVIDIA GeForce GTX 1060 6GB",
    "storage": "256 GB SSD + 1 TB HDD",
    "directx": "DirectX 12"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("System Requirements"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("System scan completed");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSystemInfo(),
            ...requirements.map((req) => _buildRequirementSection(req)),
            _buildPerformancePreview(),
            _buildOptimizationTips(),
          ],
        ),
      ),
    );
  }

  Widget _buildSystemInfo() {
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
          Row(
            children: [
              Icon(Icons.computer, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Your System",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spSm,
            children: [
              _buildSystemInfoRow("Operating System", systemInfo["os"]),
              _buildSystemInfoRow("Processor", systemInfo["processor"]),
              _buildSystemInfoRow("Memory", systemInfo["memory"]),
              _buildSystemInfoRow("Graphics", systemInfo["graphics"]),
              _buildSystemInfoRow("Storage", systemInfo["storage"]),
              _buildSystemInfoRow("DirectX", systemInfo["directx"]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSystemInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: disabledBoldColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRequirementSection(Map<String, dynamic> requirement) {
    final specs = requirement["specs"] as List;
    final metCount = specs.where((spec) => spec["met"] == true).length;
    final totalCount = specs.length;
    final percentage = (metCount / totalCount);

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
          Row(
            children: [
              Expanded(
                child: Text(
                  "${requirement["category"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: percentage == 1.0 ? successColor : percentage >= 0.7 ? warningColor : dangerColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "$metCount/$totalCount",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: disabledColor,
            valueColor: AlwaysStoppedAnimation<Color>(
              percentage == 1.0 ? successColor : percentage >= 0.7 ? warningColor : dangerColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spSm,
            children: specs.map((spec) => _buildSpecRow(spec)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecRow(Map<String, dynamic> spec) {
    return Row(
      children: [
        Icon(
          spec["met"] ? Icons.check_circle : Icons.cancel,
          size: 20,
          color: spec["met"] ? successColor : dangerColor,
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${spec["component"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
              Text(
                "${spec["requirement"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPerformancePreview() {
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
          Row(
            children: [
              Icon(Icons.speed, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Expected Performance",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildPerformanceCard("Resolution", "1080p", warningColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildPerformanceCard("FPS", "45-60", warningColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildPerformanceCard("Quality", "Medium", warningColor),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: warningColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: warningColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Your system meets minimum requirements but may experience frame drops in intensive scenes. Consider upgrading graphics card for optimal performance.",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceCard(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptimizationTips() {
    List<Map<String, dynamic>> tips = [
      {
        "icon": Icons.settings,
        "title": "Graphics Settings",
        "description": "Lower shadow quality and anti-aliasing for better performance"
      },
      {
        "icon": Icons.memory,
        "title": "Memory Optimization",
        "description": "Close unnecessary background applications before gaming"
      },
      {
        "icon": Icons.update,
        "title": "Driver Updates",
        "description": "Keep graphics drivers updated for optimal compatibility"
      },
      {
        "icon": Icons.storage,
        "title": "Storage Space",
        "description": "Ensure at least 10GB free space for temporary files"
      },
    ];

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
          Row(
            children: [
              Icon(Icons.tips_and_updates, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Optimization Tips",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spSm,
            children: tips.map((tip) => _buildTipItem(tip)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(Map<String, dynamic> tip) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(spXs),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Icon(
            tip["icon"],
            size: 20,
            color: infoColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${tip["title"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
              Text(
                "${tip["description"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
