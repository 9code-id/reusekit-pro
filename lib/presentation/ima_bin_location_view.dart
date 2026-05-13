import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaBinLocationView extends StatefulWidget {
  const ImaBinLocationView({super.key});

  @override
  State<ImaBinLocationView> createState() => _ImaBinLocationViewState();
}

class _ImaBinLocationViewState extends State<ImaBinLocationView> {
  String selectedWarehouse = "wh_001";
  String selectedZone = "all";
  String selectedRack = "all";
  String searchQuery = "";
  String filterStatus = "all";
  String sortBy = "binCode";

  List<Map<String, dynamic>> warehouses = [
    {
      "id": "wh_001",
      "name": "Main Warehouse",
      "location": "Building A",
    },
    {
      "id": "wh_002",
      "name": "Secondary Warehouse", 
      "location": "Building B",
    },
  ];

  List<Map<String, dynamic>> zones = [
    {"label": "All Zones", "value": "all"},
    {"label": "Zone A", "value": "zone_a"},
    {"label": "Zone B", "value": "zone_b"},
    {"label": "Zone C", "value": "zone_c"},
  ];

  List<Map<String, dynamic>> racks = [
    {"label": "All Racks", "value": "all"},
    {"label": "A1-001", "value": "rack_001"},
    {"label": "A1-002", "value": "rack_002"},
    {"label": "B2-001", "value": "rack_003"},
  ];

  List<Map<String, dynamic>> bins = [
    {
      "id": "bin_001",
      "warehouseId": "wh_001",
      "rackId": "rack_001",
      "binCode": "A1-001-L1-01",
      "zone": "zone_a",
      "rack": "A1-001",
      "level": 1,
      "position": "01",
      "width": 0.5,
      "height": 0.4,
      "depth": 0.3,
      "capacity": 20,
      "currentOccupancy": 15,
      "availableSpace": 5,
      "weightLimit": 50,
      "currentWeight": 38,
      "status": "occupied",
      "binType": "standard",
      "productSku": "PROD-001",
      "productName": "Laptop Computer",
      "batchNumber": "BATCH-2024-001",
      "expiryDate": null,
      "lastUpdated": "2024-12-01T14:30:00Z",
      "barcode": "BIN123456001",
      "notes": "Premium products",
      "isPickable": true,
      "isReplenishable": true
    },
    {
      "id": "bin_002",
      "warehouseId": "wh_001",
      "rackId": "rack_001",
      "binCode": "A1-001-L1-02",
      "zone": "zone_a",
      "rack": "A1-001",
      "level": 1,
      "position": "02",
      "width": 0.5,
      "height": 0.4,
      "depth": 0.3,
      "capacity": 20,
      "currentOccupancy": 0,
      "availableSpace": 20,
      "weightLimit": 50,
      "currentWeight": 0,
      "status": "empty",
      "binType": "standard",
      "productSku": null,
      "productName": null,
      "batchNumber": null,
      "expiryDate": null,
      "lastUpdated": "2024-11-28T10:15:00Z",
      "barcode": "BIN123456002",
      "notes": "",
      "isPickable": true,
      "isReplenishable": true
    },
    {
      "id": "bin_003",
      "warehouseId": "wh_001",
      "rackId": "rack_002",
      "binCode": "A1-002-L2-05",
      "zone": "zone_a",
      "rack": "A1-002",
      "level": 2,
      "position": "05",
      "width": 0.6,
      "height": 0.5,
      "depth": 0.4,
      "capacity": 30,
      "currentOccupancy": 30,
      "availableSpace": 0,
      "weightLimit": 75,
      "currentWeight": 72,
      "status": "full",
      "binType": "heavy_duty",
      "productSku": "PROD-002",
      "productName": "Server Equipment",
      "batchNumber": "BATCH-2024-002",
      "expiryDate": null,
      "lastUpdated": "2024-12-03T09:20:00Z",
      "barcode": "BIN123456003",
      "notes": "Handle with care",
      "isPickable": false,
      "isReplenishable": false
    },
    {
      "id": "bin_004",
      "warehouseId": "wh_001",
      "rackId": "rack_003",
      "binCode": "B2-001-L1-03",
      "zone": "zone_b",
      "rack": "B2-001",
      "level": 1,
      "position": "03",
      "width": 0.4,
      "height": 0.3,
      "depth": 0.25,
      "capacity": 15,
      "currentOccupancy": 8,
      "availableSpace": 7,
      "weightLimit": 30,
      "currentWeight": 18,
      "status": "reserved",
      "binType": "small",
      "productSku": "PROD-003",
      "productName": "Mobile Accessories",
      "batchNumber": "BATCH-2024-003",
      "expiryDate": "2025-06-15",
      "lastUpdated": "2024-12-02T16:45:00Z",
      "barcode": "BIN123456004",
      "notes": "Reserved for special order",
      "isPickable": false,
      "isReplenishable": true
    },
    {
      "id": "bin_005",
      "warehouseId": "wh_002",
      "rackId": "rack_004",
      "binCode": "C3-001-L3-10",
      "zone": "zone_c",
      "rack": "C3-001",
      "level": 3,
      "position": "10",
      "width": 0.8,
      "height": 0.6,
      "depth": 0.5,
      "capacity": 40,
      "currentOccupancy": 25,
      "availableSpace": 15,
      "weightLimit": 100,
      "currentWeight": 65,
      "status": "occupied",
      "binType": "large",
      "productSku": "PROD-004",
      "productName": "Industrial Equipment",
      "batchNumber": "BATCH-2024-004",
      "expiryDate": null,
      "lastUpdated": "2024-12-01T11:30:00Z",
      "barcode": "BIN123456005",
      "notes": "Industrial grade products",
      "isPickable": true,
      "isReplenishable": true
    }
  ];

  List<Map<String, dynamic>> get filteredBins {
    var filtered = bins.where((bin) {
      bool matchesWarehouse = bin["warehouseId"] == selectedWarehouse;
      bool matchesZone = selectedZone == "all" || bin["zone"] == selectedZone;
      bool matchesRack = selectedRack == "all" || bin["rackId"] == selectedRack.replaceAll("rack_", "rack_");
      bool matchesStatus = filterStatus == "all" || bin["status"] == filterStatus;
      bool matchesSearch = searchQuery.isEmpty || 
          bin["binCode"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          (bin["productSku"] != null && bin["productSku"].toString().toLowerCase().contains(searchQuery.toLowerCase())) ||
          (bin["productName"] != null && bin["productName"].toString().toLowerCase().contains(searchQuery.toLowerCase())) ||
          bin["barcode"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesWarehouse && matchesZone && matchesRack && matchesStatus && matchesSearch;
    }).toList();

    // Sort bins
    filtered.sort((a, b) {
      switch (sortBy) {
        case "binCode":
          return a["binCode"].toString().compareTo(b["binCode"].toString());
        case "capacity":
          return (b["capacity"] as int).compareTo(a["capacity"] as int);
        case "occupancy":
          return (b["currentOccupancy"] as int).compareTo(a["currentOccupancy"] as int);
        case "available":
          return (b["availableSpace"] as int).compareTo(a["availableSpace"] as int);
        case "status":
          return a["status"].toString().compareTo(b["status"].toString());
        case "lastUpdated":
          return DateTime.parse(b["lastUpdated"]).compareTo(DateTime.parse(a["lastUpdated"]));
        default:
          return 0;
      }
    });

    return filtered;
  }

  Map<String, dynamic> get selectedWarehouseData {
    return warehouses.firstWhere((warehouse) => warehouse["id"] == selectedWarehouse);
  }

  Map<String, dynamic> get binStatistics {
    var warehouseBins = bins.where((b) => b["warehouseId"] == selectedWarehouse).toList();
    var totalCapacity = warehouseBins.fold(0, (sum, b) => sum + (b["capacity"] as int));
    var totalOccupancy = warehouseBins.fold(0, (sum, b) => sum + (b["currentOccupancy"] as int));
    
    return {
      "totalBins": warehouseBins.length,
      "occupiedBins": warehouseBins.where((b) => b["status"] == "occupied").length,
      "emptyBins": warehouseBins.where((b) => b["status"] == "empty").length,
      "fullBins": warehouseBins.where((b) => b["status"] == "full").length,
      "reservedBins": warehouseBins.where((b) => b["status"] == "reserved").length,
      "totalCapacity": totalCapacity,
      "totalOccupancy": totalOccupancy,
      "utilizationRate": totalCapacity > 0 ? (totalOccupancy / totalCapacity * 100) : 0.0,
    };
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "occupied":
        return successColor;
      case "empty":
        return disabledBoldColor;
      case "full":
        return warningColor;
      case "reserved":
        return infoColor;
      case "blocked":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _formatStatus(String status) {
    switch (status) {
      case "occupied":
        return "Occupied";
      case "empty":
        return "Empty";
      case "full":
        return "Full";
      case "reserved":
        return "Reserved";
      case "blocked":
        return "Blocked";
      default:
        return "Unknown";
    }
  }

  Color _getBinTypeColor(String type) {
    switch (type) {
      case "standard":
        return primaryColor;
      case "heavy_duty":
        return infoColor;
      case "small":
        return warningColor;
      case "large":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showBinDetails(Map<String, dynamic> bin) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Bin Details - ${bin["binCode"]}"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow("Bin Code", "${bin["binCode"]}"),
              _buildDetailRow("Barcode", "${bin["barcode"]}"),
              _buildDetailRow("Zone", "${bin["zone"]}".toUpperCase()),
              _buildDetailRow("Rack", "${bin["rack"]}"),
              _buildDetailRow("Level", "Level ${bin["level"]}"),
              _buildDetailRow("Position", "${bin["position"]}"),
              _buildDetailRow("Type", "${bin["binType"]}".replaceAll("_", " ").toUpperCase()),
              _buildDetailRow("Status", _formatStatus(bin["status"])),
              Divider(),
              _buildDetailRow("Dimensions", "${bin["width"]}m × ${bin["height"]}m × ${bin["depth"]}m"),
              _buildDetailRow("Capacity", "${bin["capacity"]} units"),
              _buildDetailRow("Current Occupancy", "${bin["currentOccupancy"]} units"),
              _buildDetailRow("Available Space", "${bin["availableSpace"]} units"),
              _buildDetailRow("Weight Limit", "${bin["weightLimit"]} kg"),
              _buildDetailRow("Current Weight", "${bin["currentWeight"]} kg"),
              if (bin["productSku"] != null) ...[
                Divider(),
                _buildDetailRow("Product SKU", "${bin["productSku"]}"),
                _buildDetailRow("Product Name", "${bin["productName"]}"),
                _buildDetailRow("Batch Number", "${bin["batchNumber"]}"),
                if (bin["expiryDate"] != null)
                  _buildDetailRow("Expiry Date", "${DateTime.parse(bin["expiryDate"]).dMMMy}"),
              ],
              Divider(),
              _buildDetailRow("Pickable", bin["isPickable"] ? "Yes" : "No"),
              _buildDetailRow("Replenishable", bin["isReplenishable"] ? "Yes" : "No"),
              _buildDetailRow("Last Updated", "${DateTime.parse(bin["lastUpdated"]).dMMMy} at ${DateTime.parse(bin["lastUpdated"]).kkmm}"),
              if (bin["notes"].toString().isNotEmpty)
                _buildDetailRow("Notes", "${bin["notes"]}"),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Edit Bin",
            size: bs.sm,
            onPressed: () {
              Navigator.of(context).pop();
              ss("Edit bin feature");
            },
          ),
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: color),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBinCard(Map<String, dynamic> bin) {
    double utilizationRate = (bin["capacity"] as int) > 0 
        ? ((bin["currentOccupancy"] as int) / (bin["capacity"] as int) * 100) 
        : 0.0;
    double weightUtilization = (bin["weightLimit"] as int) > 0 
        ? ((bin["currentWeight"] as int) / (bin["weightLimit"] as int) * 100) 
        : 0.0;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor(bin["status"]),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: _getBinTypeColor(bin["binType"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  Icons.inventory_2,
                  size: 18,
                  color: _getBinTypeColor(bin["binType"]),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${bin["binCode"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getStatusColor(bin["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            _formatStatus(bin["status"]),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(bin["status"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          "${bin["rack"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "•",
                          style: TextStyle(color: disabledBoldColor),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "L${bin["level"]}-${bin["position"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "•",
                          style: TextStyle(color: disabledBoldColor),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${bin["binType"]}".replaceAll("_", " ").toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          if (bin["productSku"] != null) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.inventory, size: 14, color: primaryColor),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "${bin["productName"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Text(
                    "SKU: ${bin["productSku"]} • Batch: ${bin["batchNumber"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                  if (bin["expiryDate"] != null) ...[
                    SizedBox(height: 2),
                    Text(
                      "Expires: ${DateTime.parse(bin["expiryDate"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 10,
                        color: warningColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
          
          SizedBox(height: spSm),
          
          // Utilization Info
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Space",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 2),
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: FractionallySizedBox(
                        widthFactor: utilizationRate / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: utilizationRate > 80 
                                ? dangerColor 
                                : utilizationRate > 60 
                                ? warningColor 
                                : successColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "${bin["currentOccupancy"]}/${bin["capacity"]} (${utilizationRate.toStringAsFixed(0)}%)",
                      style: TextStyle(
                        fontSize: 9,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Weight",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 2),
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: FractionallySizedBox(
                        widthFactor: weightUtilization / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: weightUtilization > 80 
                                ? dangerColor 
                                : weightUtilization > 60 
                                ? warningColor 
                                : successColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "${bin["currentWeight"]}/${bin["weightLimit"]}kg (${weightUtilization.toStringAsFixed(0)}%)",
                      style: TextStyle(
                        fontSize: 9,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          Row(
            children: [
              Row(
                children: [
                  if (bin["isPickable"])
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      margin: EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "PICK",
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ),
                  if (bin["isReplenishable"])
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "REPL",
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ),
                ],
              ),
              Spacer(),
              Text(
                "Updated: ${DateTime.parse(bin["lastUpdated"]).dMMMy}",
                style: TextStyle(
                  fontSize: 9,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spXs),
              GestureDetector(
                onTap: () => _showBinDetails(bin),
                child: Icon(
                  Icons.info_outline,
                  size: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var stats = binStatistics;

    return Scaffold(
      appBar: AppBar(
        title: Text("Bin Locations"),
        actions: [
          QButton(
            icon: Icons.qr_code_scanner,
            size: bs.sm,
            onPressed: () {
              ss("Scan bin barcode");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Warehouse Selection
            QDropdownField(
              label: "Select Warehouse",
              items: warehouses.map((w) => {
                "label": "${w["name"]} - ${w["location"]}",
                "value": "${w["id"]}"
              }).toList(),
              value: selectedWarehouse,
              onChanged: (value, label) {
                selectedWarehouse = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Warehouse Info Card
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warehouse, color: primaryColor, size: 20),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${selectedWarehouseData["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${selectedWarehouseData["location"]}",
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
            SizedBox(height: spMd),

            // Statistics
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Total Bins",
                    "${stats["totalBins"]}",
                    Icons.inventory_2,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: _buildStatCard(
                    "Occupied",
                    "${stats["occupiedBins"]}",
                    Icons.check_circle,
                    successColor,
                  ),
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: _buildStatCard(
                    "Empty",
                    "${stats["emptyBins"]}",
                    Icons.crop_free,
                    disabledBoldColor,
                  ),
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: _buildStatCard(
                    "Full",
                    "${stats["fullBins"]}",
                    Icons.warning,
                    warningColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Reserved",
                    "${stats["reservedBins"]}",
                    Icons.lock,
                    infoColor,
                  ),
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: _buildStatCard(
                    "Capacity",
                    "${stats["totalCapacity"]}",
                    Icons.inventory,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: _buildStatCard(
                    "Occupancy",
                    "${stats["totalOccupancy"]}",
                    Icons.business_center,
                    successColor,
                  ),
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: _buildStatCard(
                    "Utilization",
                    "${(stats["utilizationRate"] as double).toStringAsFixed(1)}%",
                    Icons.analytics,
                    warningColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Filters and Search
            QTextField(
              label: "Search bins...",
              value: searchQuery,
              hint: "Bin code, product SKU, or barcode",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Zone",
                    items: zones,
                    value: selectedZone,
                    onChanged: (value, label) {
                      selectedZone = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Rack",
                    items: racks,
                    value: selectedRack,
                    onChanged: (value, label) {
                      selectedRack = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Status",
                    items: [
                      {"label": "All Status", "value": "all"},
                      {"label": "Occupied", "value": "occupied"},
                      {"label": "Empty", "value": "empty"},
                      {"label": "Full", "value": "full"},
                      {"label": "Reserved", "value": "reserved"},
                      {"label": "Blocked", "value": "blocked"},
                    ],
                    value: filterStatus,
                    onChanged: (value, label) {
                      filterStatus = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort by",
                    items: [
                      {"label": "Bin Code", "value": "binCode"},
                      {"label": "Capacity", "value": "capacity"},
                      {"label": "Occupancy", "value": "occupancy"},
                      {"label": "Available Space", "value": "available"},
                      {"label": "Status", "value": "status"},
                      {"label": "Last Updated", "value": "lastUpdated"},
                    ],
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Add New Bin",
                    icon: Icons.add,
                    size: bs.sm,
                    onPressed: () {
                      ss("Add new bin location");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Export List",
                    icon: Icons.file_download,
                    size: bs.sm,
                    onPressed: () {
                      ss("Export bin list");
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Bin List
            Text(
              "Bin Locations (${filteredBins.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            if (filteredBins.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No bins found",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or add new bin locations",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredBins.map((bin) => _buildBinCard(bin)).toList(),
          ],
        ),
      ),
    );
  }
}
