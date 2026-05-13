import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStorage7View extends StatefulWidget {
  @override
  State<GrlStorage7View> createState() => _GrlStorage7ViewState();
}

class _GrlStorage7ViewState extends State<GrlStorage7View> {
  String selectedStorageType = "All";
  bool showUsageAlert = true;
  
  List<Map<String, dynamic>> storageFilters = [
    {"label": "All", "value": "All"},
    {"label": "Internal", "value": "Internal"},
    {"label": "External", "value": "External"},
    {"label": "Cloud", "value": "Cloud"},
    {"label": "Network", "value": "Network"},
  ];

  List<Map<String, dynamic>> storageLocations = [
    {
      "name": "Internal Storage",
      "path": "/storage/emulated/0",
      "type": "Internal",
      "totalSpace": 128.0,
      "freeSpace": 32.4,
      "usedSpace": 95.6,
      "health": 94,
      "temperature": 38,
      "writeSpeed": 450.2,
      "readSpeed": 523.8,
      "icon": Icons.smartphone,
      "color": primaryColor,
      "status": "Optimal"
    },
    {
      "name": "SD Card",
      "path": "/storage/sdcard1",
      "type": "External",
      "totalSpace": 64.0,
      "freeSpace": 8.2,
      "usedSpace": 55.8,
      "health": 89,
      "temperature": 35,
      "writeSpeed": 85.4,
      "readSpeed": 92.1,
      "icon": Icons.sd_card,
      "color": warningColor,
      "status": "Nearly Full"
    },
    {
      "name": "Google Drive",
      "path": "/cloud/gdrive",
      "type": "Cloud",
      "totalSpace": 2000.0,
      "freeSpace": 1456.7,
      "usedSpace": 543.3,
      "health": 100,
      "temperature": 0,
      "writeSpeed": 12.5,
      "readSpeed": 18.3,
      "icon": Icons.cloud,
      "color": successColor,
      "status": "Synced"
    },
    {
      "name": "USB Drive",
      "path": "/mnt/usb",
      "type": "External",
      "totalSpace": 32.0,
      "freeSpace": 0.5,
      "usedSpace": 31.5,
      "health": 78,
      "temperature": 42,
      "writeSpeed": 25.8,
      "readSpeed": 30.2,
      "icon": Icons.usb,
      "color": dangerColor,
      "status": "Critical"
    },
    {
      "name": "Network Drive",
      "path": "//192.168.1.100/share",
      "type": "Network",
      "totalSpace": 1000.0,
      "freeSpace": 234.8,
      "usedSpace": 765.2,
      "health": 96,
      "temperature": 28,
      "writeSpeed": 78.9,
      "readSpeed": 112.4,
      "icon": Icons.router,
      "color": infoColor,
      "status": "Connected"
    }
  ];

  List<Map<String, dynamic>> folderSizes = [
    {
      "name": "Photos",
      "path": "/DCIM/Camera",
      "size": 12.8,
      "unit": "GB",
      "fileCount": 2847,
      "icon": Icons.photo_library,
      "color": successColor,
      "lastModified": "2 hours ago"
    },
    {
      "name": "Downloads",
      "path": "/Download",
      "size": 8.4,
      "unit": "GB",
      "fileCount": 156,
      "icon": Icons.download,
      "color": warningColor,
      "lastModified": "1 day ago"
    },
    {
      "name": "WhatsApp Media",
      "path": "/WhatsApp/Media",
      "size": 5.2,
      "unit": "GB",
      "fileCount": 1234,
      "icon": Icons.chat,
      "color": primaryColor,
      "lastModified": "30 minutes ago"
    },
    {
      "name": "Music",
      "path": "/Music",
      "size": 3.1,
      "unit": "GB",
      "fileCount": 789,
      "icon": Icons.music_note,
      "color": infoColor,
      "lastModified": "1 week ago"
    },
    {
      "name": "Documents",
      "path": "/Documents",
      "size": 1.8,
      "unit": "GB",
      "fileCount": 234,
      "icon": Icons.description,
      "color": dangerColor,
      "lastModified": "3 days ago"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Storage Explorer"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              _showSortOptions();
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
            if (showUsageAlert) _buildUsageAlert(),
            _buildStorageOverview(),
            _buildStorageFilter(),
            _buildStorageLocationsList(),
            _buildTopFolders(),
            _buildStorageActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildUsageAlert() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: warningColor.withAlpha(40)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning,
            color: warningColor,
            size: 24,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Storage Warning",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Your internal storage is 75% full. Consider cleaning up files or moving them to external storage.",
                  style: TextStyle(
                    fontSize: 14,
                    color: warningColor,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              showUsageAlert = false;
              setState(() {});
            },
            child: Icon(
              Icons.close,
              color: warningColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStorageOverview() {
    double totalSpace = storageLocations.fold(0.0, (sum, storage) => sum + (storage["totalSpace"] as double));
    double usedSpace = storageLocations.fold(0.0, (sum, storage) => sum + (storage["usedSpace"] as double));
    double freeSpace = storageLocations.fold(0.0, (sum, storage) => sum + (storage["freeSpace"] as double));
    double usagePercentage = (usedSpace / totalSpace) * 100;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.storage,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: spSm),
              Text(
                "Total Storage Overview",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${usedSpace.toStringAsFixed(1)} GB",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Used",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${freeSpace.toStringAsFixed(1)} GB",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Free",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${usagePercentage.toStringAsFixed(0)}%",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Usage",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStorageFilter() {
    return QCategoryPicker(
      items: storageFilters,
      value: selectedStorageType,
      onChanged: (index, label, value, item) {
        selectedStorageType = value;
        setState(() {});
      },
    );
  }

  Widget _buildStorageLocationsList() {
    List<Map<String, dynamic>> filteredLocations = selectedStorageType == "All" 
        ? storageLocations 
        : storageLocations.where((storage) => storage["type"] == selectedStorageType).toList();

    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Storage Locations",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...filteredLocations.map((storage) => _buildStorageLocationCard(storage)),
      ],
    );
  }

  Widget _buildStorageLocationCard(Map<String, dynamic> storage) {
    double usagePercentage = ((storage["usedSpace"] as double) / (storage["totalSpace"] as double)) * 100;

    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: storage["color"] as Color,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (storage["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  storage["icon"] as IconData,
                  color: storage["color"] as Color,
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${storage["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${storage["path"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${storage["type"]} Storage",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: (storage["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${storage["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: storage["color"] as Color,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${storage["usedSpace"]} GB used",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "of ${storage["totalSpace"]} GB total",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (storage["type"] != "Cloud") ...[
                Column(
                  children: [
                    Text(
                      "Health",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${storage["health"]}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: spMd),
                if (storage["temperature"] > 0) ...[
                  Column(
                    children: [
                      Text(
                        "Temp",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${storage["temperature"]}°C",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ],
          ),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              widthFactor: usagePercentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: storage["color"] as Color,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Text(
                "${usagePercentage.toStringAsFixed(1)}% used • ${storage["freeSpace"]} GB free",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if (storage["type"] != "Cloud") ...[
                Text(
                  "R: ${storage["readSpeed"]} MB/s • W: ${storage["writeSpeed"]} MB/s",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopFolders() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Largest Folders",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                si("Opening folder analysis");
              },
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        ...folderSizes.map((folder) => _buildFolderItem(folder)),
      ],
    );
  }

  Widget _buildFolderItem(Map<String, dynamic> folder) {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (folder["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              folder["icon"] as IconData,
              color: folder["color"] as Color,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${folder["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${folder["path"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${folder["fileCount"]} files • ${folder["lastModified"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${folder["size"]} ${folder["unit"]}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: folder["color"] as Color,
                ),
              ),
              Text(
                "Size",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStorageActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Storage Management",
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
                  label: "Clean Files",
                  icon: Icons.cleaning_services,
                  size: bs.sm,
                  onPressed: () {
                    ss("Starting file cleanup");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Move Files",
                  icon: Icons.drive_file_move,
                  size: bs.sm,
                  onPressed: () {
                    si("Opening file move dialog");
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Compress",
                  icon: Icons.compress,
                  size: bs.sm,
                  onPressed: () {
                    si("Starting file compression");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Backup",
                  icon: Icons.backup,
                  size: bs.sm,
                  onPressed: () {
                    si("Starting backup process");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSortOptions() {
    // This would show a bottom sheet with sort options
    si("Sort options: Size, Name, Type, Date");
  }
}
