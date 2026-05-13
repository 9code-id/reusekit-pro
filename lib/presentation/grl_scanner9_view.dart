import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlScanner9View extends StatefulWidget {
  @override
  State<GrlScanner9View> createState() => _GrlScanner9ViewState();
}

class _GrlScanner9ViewState extends State<GrlScanner9View> {
  String selectedFilter = "All Time";
  String searchQuery = "";
  String selectedCategory = "All";
  
  List<String> filterOptions = ["All Time", "Today", "This Week", "This Month"];
  List<String> categoryOptions = ["All", "URL", "Product", "Contact", "WiFi", "Text"];
  
  List<Map<String, dynamic>> scanHistory = [
    {
      "id": "1",
      "type": "QR Code",
      "content": "https://flutter.dev/docs",
      "timestamp": "2024-01-15 14:30:25",
      "category": "URL",
      "favorite": true,
      "session": "Web Development Session",
      "location": "Office Building A",
      "duration": "2.3s",
    },
    {
      "id": "2",
      "type": "Barcode",
      "content": "1234567890123",
      "timestamp": "2024-01-15 13:45:12",
      "category": "Product",
      "favorite": false,
      "session": "Inventory Check",
      "location": "Warehouse B",
      "duration": "1.8s",
    },
    {
      "id": "3",
      "type": "QR Code",
      "content": "BEGIN:VCARD\nFN:John Doe\nTEL:+1234567890\nEMAIL:john@example.com\nEND:VCARD",
      "timestamp": "2024-01-15 12:15:30",
      "category": "Contact",
      "favorite": true,
      "session": "Networking Event",
      "location": "Conference Hall",
      "duration": "3.1s",
    },
    {
      "id": "4",
      "type": "QR Code",
      "content": "WIFI:T:WPA;S:MyNetwork;P:password123;H:false;;",
      "timestamp": "2024-01-15 11:20:45",
      "category": "WiFi",
      "favorite": false,
      "session": "Setup Session",
      "location": "Client Office",
      "duration": "2.7s",
    },
    {
      "id": "5",
      "type": "Barcode",
      "content": "9876543210987",
      "timestamp": "2024-01-14 16:35:18",
      "category": "Product",
      "favorite": false,
      "session": "Store Audit",
      "location": "Retail Store C",
      "duration": "1.5s",
    },
    {
      "id": "6",
      "type": "QR Code",
      "content": "https://github.com/flutter/flutter",
      "timestamp": "2024-01-14 15:22:33",
      "category": "URL",
      "favorite": true,
      "session": "Code Review",
      "location": "Development Office",
      "duration": "2.9s",
    },
  ];

  List<Map<String, dynamic>> get filteredHistory {
    List<Map<String, dynamic>> filtered = scanHistory;
    
    // Filter by time
    DateTime now = DateTime.now();
    if (selectedFilter == "Today") {
      filtered = filtered.where((item) {
        DateTime scanTime = DateTime.parse(item["timestamp"]);
        return scanTime.day == now.day && 
               scanTime.month == now.month && 
               scanTime.year == now.year;
      }).toList();
    } else if (selectedFilter == "This Week") {
      DateTime weekStart = now.subtract(Duration(days: now.weekday - 1));
      filtered = filtered.where((item) {
        DateTime scanTime = DateTime.parse(item["timestamp"]);
        return scanTime.isAfter(weekStart);
      }).toList();
    } else if (selectedFilter == "This Month") {
      filtered = filtered.where((item) {
        DateTime scanTime = DateTime.parse(item["timestamp"]);
        return scanTime.month == now.month && scanTime.year == now.year;
      }).toList();
    }
    
    // Filter by category
    if (selectedCategory != "All") {
      filtered = filtered.where((item) => item["category"] == selectedCategory).toList();
    }
    
    // Filter by search
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((item) => 
        item["content"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        item["session"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        item["location"].toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detailed History"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterOptions();
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              ss("Export completed");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                // Search Bar
                QTextField(
                  label: "Search history...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                
                // Filter Chips
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QCategoryPicker(
                        items: filterOptions.map((filter) => {
                          "label": filter,
                          "value": filter,
                        }).toList(),
                        value: selectedFilter,
                        onChanged: (index, label, value, item) {
                          selectedFilter = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Statistics Bar
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              border: Border(
                bottom: BorderSide(color: disabledOutlineBorderColor),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "${filteredHistory.length}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Scans",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 1,
                  height: 32,
                  color: disabledOutlineBorderColor,
                ),
                Column(
                  children: [
                    Text(
                      "${filteredHistory.where((item) => item["favorite"] == true).length}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "Favorites",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 1,
                  height: 32,
                  color: disabledOutlineBorderColor,
                ),
                Column(
                  children: [
                    Text(
                      "${filteredHistory.map((item) => item["session"]).toSet().length}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Sessions",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // History List
          Expanded(
            child: filteredHistory.isEmpty
                ? Container(
                    padding: EdgeInsets.all(spLg),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "No results found",
                          style: TextStyle(
                            fontSize: fsH6,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Try adjusting your search or filters",
                          style: TextStyle(
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: filteredHistory.length,
                    itemBuilder: (context, index) {
                      return _buildDetailedHistoryItem(filteredHistory[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedHistoryItem(Map<String, dynamic> scan) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          // Header Row
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getCategoryColor(scan["category"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  _getCategoryIcon(scan["category"]),
                  color: _getCategoryColor(scan["category"]),
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(scan["category"]),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${scan["type"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${scan["category"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${scan["session"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    scan["favorite"] = !(scan["favorite"] as bool);
                  });
                },
                child: Icon(
                  scan["favorite"] == true ? Icons.favorite : Icons.favorite_border,
                  color: scan["favorite"] == true ? dangerColor : disabledColor,
                  size: 24,
                ),
              ),
            ],
          ),
          
          // Content
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${scan["content"]}",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'monospace',
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          // Metadata
          Row(
            children: [
              Expanded(
                child: Row(
                  spacing: spXs,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    Text(
                      "${scan["timestamp"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                spacing: spXs,
                children: [
                  Icon(
                    Icons.timer,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                  Text(
                    "${scan["duration"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          Row(
            spacing: spXs,
            children: [
              Icon(
                Icons.location_on,
                size: 16,
                color: disabledBoldColor,
              ),
              Expanded(
                child: Text(
                  "${scan["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          
          // Actions
          Divider(),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Copy",
                  size: bs.sm,
                  onPressed: () {
                    ss("Content copied");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Share",
                  size: bs.sm,
                  onPressed: () {
                    ss("Content shared");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Details",
                  size: bs.sm,
                  onPressed: () {
                    _showScanDetails(scan);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Color _getCategoryColor(String category) {
    switch (category) {
      case "URL":
        return infoColor;
      case "Product":
        return warningColor;
      case "Contact":
        return successColor;
      case "WiFi":
        return primaryColor;
      case "Text":
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }
  
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "URL":
        return Icons.link;
      case "Product":
        return Icons.inventory;
      case "Contact":
        return Icons.person;
      case "WiFi":
        return Icons.wifi;
      case "Text":
        return Icons.text_fields;
      default:
        return Icons.qr_code;
    }
  }
  
  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
            Text(
              "Filter Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            QDropdownField(
              label: "Category",
              items: categoryOptions.map((category) => {
                "label": category,
                "value": category,
              }).toList(),
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
                back();
              },
            ),
          ],
        ),
      ),
    );
  }
  
  void _showScanDetails(Map<String, dynamic> scan) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
            Text(
              "Scan Details",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: spMd,
                  children: [
                    _buildDetailRow("Type", "${scan["type"]}"),
                    _buildDetailRow("Category", "${scan["category"]}"),
                    _buildDetailRow("Session", "${scan["session"]}"),
                    _buildDetailRow("Location", "${scan["location"]}"),
                    _buildDetailRow("Timestamp", "${scan["timestamp"]}"),
                    _buildDetailRow("Duration", "${scan["duration"]}"),
                    
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Content",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${scan["content"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            QButton(
              label: "Close",
              size: bs.md,
              onPressed: () => back(),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
