import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaRfidTrackingView extends StatefulWidget {
  const ImaRfidTrackingView({super.key});

  @override
  State<ImaRfidTrackingView> createState() => _ImaRfidTrackingViewState();
}

class _ImaRfidTrackingViewState extends State<ImaRfidTrackingView> {
  bool loading = false;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedFrequency = "All";
  
  List<Map<String, dynamic>> rfidTags = [
    {
      "id": "RFID001",
      "tagId": "E280 1166 0000 0001 2345 6789",
      "epc": "3414FA4A00000001",
      "frequency": "860-960 MHz",
      "protocol": "EPC Class 1 Gen 2",
      "productName": "MacBook Pro 16-inch",
      "productId": "PROD001",
      "assetNumber": "AST-001",
      "status": "Active",
      "lastRead": "2024-06-19 10:30:00",
      "readCount": 234,
      "location": "Office-101",
      "rssi": -45,
      "batteryLevel": 85,
      "range": "10 meters",
      "manufacturer": "Impinj",
      "model": "Monza R6",
      "encodeDate": "2024-01-15",
      "description": "Asset tracking tag for laptop",
    },
    {
      "id": "RFID002",
      "tagId": "E280 1166 0000 0002 2345 6789",
      "epc": "3414FA4A00000002",
      "frequency": "125-134 kHz",
      "protocol": "ISO 18000-2",
      "productName": "Organic Milk Carton",
      "productId": "PROD002",
      "assetNumber": "INV-002",
      "status": "Active",
      "lastRead": "2024-06-19 09:15:00",
      "readCount": 89,
      "location": "Cold Storage-B1",
      "rssi": -38,
      "batteryLevel": null,
      "range": "0.5 meters",
      "manufacturer": "NXP",
      "model": "ICODE SLIX",
      "encodeDate": "2024-06-05",
      "description": "Product tracking tag for perishables",
    },
    {
      "id": "RFID003",
      "tagId": "E280 1166 0000 0003 2345 6789",
      "epc": "3414FA4A00000003",
      "frequency": "860-960 MHz",
      "protocol": "EPC Class 1 Gen 2",
      "productName": "Pharmaceutical Batch BT001",
      "productId": "BATCH001",
      "assetNumber": "MED-003",
      "status": "Active",
      "lastRead": "2024-06-19 11:45:00",
      "readCount": 156,
      "location": "Pharmacy-A1",
      "rssi": -42,
      "batteryLevel": 92,
      "range": "15 meters",
      "manufacturer": "Alien",
      "model": "Higgs-4",
      "encodeDate": "2024-02-01",
      "description": "Batch tracking tag with temperature sensor",
    },
    {
      "id": "RFID004",
      "tagId": "E280 1166 0000 0004 2345 6789",
      "epc": "3414FA4A00000004",
      "frequency": "13.56 MHz",
      "protocol": "ISO 14443",
      "productName": "Smart ID Card",
      "productId": "CARD004",
      "assetNumber": "ID-004",
      "status": "Inactive",
      "lastRead": "2024-06-15 16:20:00",
      "readCount": 45,
      "location": "Security Office",
      "rssi": -25,
      "batteryLevel": null,
      "range": "0.1 meters",
      "manufacturer": "NFC Solutions",
      "model": "NTAG213",
      "encodeDate": "2024-03-10",
      "description": "Employee access card with NFC",
    },
    {
      "id": "RFID005",
      "tagId": "E280 1166 0000 0005 2345 6789",
      "epc": "3414FA4A00000005",
      "frequency": "860-960 MHz",
      "protocol": "EPC Class 1 Gen 2",
      "productName": "Warehouse Pallet #P001",
      "productId": "PALLET001",
      "assetNumber": "PAL-005",
      "status": "Lost Signal",
      "lastRead": "2024-06-17 14:30:00",
      "readCount": 312,
      "location": "Warehouse-C2",
      "rssi": -60,
      "batteryLevel": 15,
      "range": "20 meters",
      "manufacturer": "Impinj",
      "model": "Monza R6-P",
      "encodeDate": "2024-01-20",
      "description": "Pallet tracking tag for logistics",
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"},
    {"label": "Lost Signal", "value": "Lost Signal"},
    {"label": "Error", "value": "Error"},
    {"label": "Maintenance", "value": "Maintenance"},
  ];

  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "All", "value": "All"},
    {"label": "125-134 kHz (LF)", "value": "125-134 kHz"},
    {"label": "13.56 MHz (HF)", "value": "13.56 MHz"},
    {"label": "860-960 MHz (UHF)", "value": "860-960 MHz"},
    {"label": "2.4 GHz (Microwave)", "value": "2.4 GHz"},
  ];

  List<Map<String, dynamic>> get filteredTags {
    var items = rfidTags.where((tag) {
      bool matchesSearch = "${tag["tagId"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${tag["productName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${tag["epc"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${tag["assetNumber"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || tag["status"] == selectedStatus;
      bool matchesFrequency = selectedFrequency == "All" || tag["frequency"] == selectedFrequency;
      
      return matchesSearch && matchesStatus && matchesFrequency;
    }).toList();

    // Sort by last read time (most recent first)
    items.sort((a, b) => "${b["lastRead"]}".compareTo("${a["lastRead"]}"));
    
    return items;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Inactive":
        return disabledBoldColor;
      case "Lost Signal":
        return dangerColor;
      case "Error":
        return Colors.red.shade700;
      case "Maintenance":
        return warningColor;
      default:
        return primaryColor;
    }
  }

  Color _getSignalColor(int rssi) {
    if (rssi >= -30) return successColor;
    if (rssi >= -50) return warningColor;
    return dangerColor;
  }

  Color _getBatteryColor(int? battery) {
    if (battery == null) return disabledBoldColor;
    if (battery >= 50) return successColor;
    if (battery >= 20) return warningColor;
    return dangerColor;
  }

  int get totalTags {
    return filteredTags.length;
  }

  int get activeTags {
    return filteredTags.where((tag) => tag["status"] == "Active").length;
  }

  int get totalReads {
    return filteredTags.fold(0, (sum, tag) => sum + (tag["readCount"] as int));
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("RFID Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.nfc),
            onPressed: () {
              // Navigate to RFID reader
            },
          ),
          IconButton(
            icon: Icon(Icons.settings_remote),
            onPressed: () {
              // Navigate to reader settings
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
            _buildSummaryCards(),
            _buildFilters(),
            _buildRFIDList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new RFID tag
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildSummaryCard(
                "Total Tags",
                "$totalTags",
                Icons.nfc,
                primaryColor,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildSummaryCard(
                "Active Tags",
                "$activeTags",
                Icons.check_circle,
                successColor,
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          child: _buildSummaryCard(
            "Total Reads",
            "${totalReads.toString()}",
            Icons.scanner,
            infoColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search RFID tags...",
                value: searchQuery,
                hint: "Search by tag ID, product, EPC, or asset number",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Status",
                items: statusOptions,
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Frequency",
                items: frequencyOptions,
                value: selectedFrequency,
                onChanged: (value, label) {
                  selectedFrequency = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRFIDList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "RFID Tags (${filteredTags.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: filteredTags.length,
          itemBuilder: (context, index) {
            final tag = filteredTags[index];
            return _buildRFIDItem(tag);
          },
        ),
      ],
    );
  }

  Widget _buildRFIDItem(Map<String, dynamic> tag) {
    int rssi = tag["rssi"] as int;
    int? batteryLevel = tag["batteryLevel"] as int?;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor("${tag["status"]}"),
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: _getStatusColor("${tag["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.nfc,
                  color: _getStatusColor("${tag["status"]}"),
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${tag["productName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Tag ID: ${tag["tagId"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                        fontFamily: 'monospace',
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "EPC: ${tag["epc"]} | Asset: ${tag["assetNumber"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor("${tag["status"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${tag["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: _getStatusColor("${tag["status"]}"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${tag["frequency"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(color: disabledColor),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Signal Strength",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.signal_cellular_alt,
                          color: _getSignalColor(rssi),
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${rssi} dBm",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _getSignalColor(rssi),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Battery",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (batteryLevel != null) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.battery_full,
                            color: _getBatteryColor(batteryLevel),
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${batteryLevel}%",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _getBatteryColor(batteryLevel),
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      Text(
                        "N/A",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Read Count",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${tag["readCount"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Range",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${tag["range"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Protocol",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${tag["protocol"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${tag["location"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hardware Details",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Manufacturer: ${tag["manufacturer"]} | Model: ${tag["model"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Encoded: ${tag["encodeDate"]} | Last Read: ${tag["lastRead"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Text(
                  "${tag["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showRFIDActions(tag);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showRFIDActions(Map<String, dynamic> tag) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "RFID Tag Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            ListTile(
              leading: Icon(Icons.visibility, color: primaryColor),
              title: Text("View Details"),
              onTap: () {
                back();
                // Navigate to tag details
              },
            ),
            ListTile(
              leading: Icon(Icons.history, color: infoColor),
              title: Text("Read History"),
              onTap: () {
                back();
                _viewReadHistory(tag);
              },
            ),
            ListTile(
              leading: Icon(Icons.edit, color: warningColor),
              title: Text("Edit Tag"),
              onTap: () {
                back();
                _editTag(tag);
              },
            ),
            ListTile(
              leading: Icon(Icons.nfc, color: successColor),
              title: Text("Force Read"),
              onTap: () {
                back();
                _forceRead(tag);
              },
            ),
            ListTile(
              leading: Icon(Icons.edit, color: primaryColor),
              title: Text("Write Data"),
              onTap: () {
                back();
                _writeData(tag);
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: infoColor),
              title: Text("Locate Tag"),
              onTap: () {
                back();
                _locateTag(tag);
              },
            ),
            ListTile(
              leading: Icon(Icons.lock, color: warningColor),
              title: Text("Lock/Unlock"),
              onTap: () {
                back();
                _toggleLock(tag);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Deactivate Tag"),
              onTap: () {
                back();
                _deactivateTag(tag);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _viewReadHistory(Map<String, dynamic> tag) {
    // View read history logic
  }

  void _editTag(Map<String, dynamic> tag) {
    // Edit tag logic
    ss("RFID tag updated successfully");
  }

  void _forceRead(Map<String, dynamic> tag) {
    // Force read logic
    ss("Force read initiated for tag ${tag["assetNumber"]}");
  }

  void _writeData(Map<String, dynamic> tag) {
    // Write data logic
    ss("Data written to tag successfully");
  }

  void _locateTag(Map<String, dynamic> tag) {
    // Locate tag logic
    ss("Locating tag ${tag["assetNumber"]}...");
  }

  void _toggleLock(Map<String, dynamic> tag) {
    // Toggle lock logic
    ss("Tag lock status updated");
  }

  void _deactivateTag(Map<String, dynamic> tag) async {
    bool isConfirmed = await confirm("Deactivate this RFID tag?");
    if (isConfirmed) {
      // Deactivate tag logic
      ss("RFID tag deactivated successfully");
    }
  }
}
