import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaTitleManagementView extends StatefulWidget {
  const CmaTitleManagementView({super.key});

  @override
  State<CmaTitleManagementView> createState() => _CmaTitleManagementViewState();
}

class _CmaTitleManagementViewState extends State<CmaTitleManagementView> {
  int currentTab = 0;
  String selectedVehicle = "2023 Toyota Camry - ABC123";
  
  List<Map<String, dynamic>> vehicleOptions = [
    {"label": "2023 Toyota Camry - ABC123", "value": "2023 Toyota Camry - ABC123"},
    {"label": "2021 Honda Civic - XYZ789", "value": "2021 Honda Civic - XYZ789"},
    {"label": "2020 Ford Explorer - DEF456", "value": "2020 Ford Explorer - DEF456"},
  ];

  Map<String, dynamic> titleInfo = {
    "titleNumber": "TX-2023-ABC123-001",
    "titleStatus": "Clear",
    "issuedDate": "2023-03-15",
    "state": "Texas",
    "titleType": "Electronic",
    "lienStatus": "Paid Off",
    "previousLien": "Toyota Motor Credit",
    "lienReleaseDate": "2024-01-15",
    "ownerName": "John Smith",
    "coOwnerName": null,
    "registeredAddress": "123 Main St, Dallas, TX 75201",
    "mileageOnTitle": 15000,
    "titleFees": 75.00,
    "registrationFees": 45.50,
    "totalFees": 120.50,
    "expirationDate": "2025-03-15",
    "renewalRequired": false
  };

  List<Map<String, dynamic>> titleHistory = [
    {
      "date": "2024-01-15",
      "action": "Lien Release",
      "description": "Lien released by Toyota Motor Credit",
      "fee": 0.00,
      "status": "Completed"
    },
    {
      "date": "2023-03-15",
      "action": "Title Transfer",
      "description": "Transferred from Sarah Johnson to John Smith",
      "fee": 75.00,
      "status": "Completed"
    },
    {
      "date": "2023-03-15",
      "action": "Registration",
      "description": "Vehicle registered in Texas",
      "fee": 45.50,
      "status": "Completed"
    },
    {
      "date": "2023-03-10",
      "action": "Title Application",
      "description": "Application submitted for title transfer",
      "fee": 25.00,
      "status": "Completed"
    }
  ];

  List<Map<String, dynamic>> requiredDocuments = [
    {
      "document": "Current Title",
      "status": "Verified",
      "required": true,
      "description": "Original title with no liens"
    },
    {
      "document": "Bill of Sale",
      "status": "Verified",
      "required": true,
      "description": "Notarized bill of sale"
    },
    {
      "document": "Identity Verification",
      "status": "Verified",
      "required": true,
      "description": "Driver's license or state ID"
    },
    {
      "document": "Insurance Proof",
      "status": "Verified",
      "required": true,
      "description": "Current insurance certificate"
    },
    {
      "document": "Emissions Certificate",
      "status": "Not Required",
      "required": false,
      "description": "Not required in your county"
    }
  ];

  Color _getTitleStatusColor(String status) {
    switch (status) {
      case "Clear":
        return successColor;
      case "Lien":
        return warningColor;
      case "Salvage":
        return dangerColor;
      case "Flood":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getDocumentStatusColor(String status) {
    switch (status) {
      case "Verified":
        return successColor;
      case "Pending":
        return warningColor;
      case "Missing":
        return dangerColor;
      case "Not Required":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Title Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Current Title", icon: Icon(Icons.description)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Documents", icon: Icon(Icons.folder)),
        Tab(text: "Transfer", icon: Icon(Icons.swap_horiz)),
      ],
      tabChildren: [
        // Current Title Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vehicle Selection
              QDropdownField(
                label: "Select Vehicle",
                items: vehicleOptions,
                value: selectedVehicle,
                onChanged: (value, label) {
                  selectedVehicle = value;
                  setState(() {});
                },
              ),

              // Title Status Card
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_getTitleStatusColor(titleInfo["titleStatus"]), _getTitleStatusColor(titleInfo["titleStatus"]).withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.verified, color: Colors.white, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Title Status: ${titleInfo["titleStatus"]}",
                          style: TextStyle(
                            fontSize: fsH6,
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
                                "${titleInfo["titleNumber"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Title Number",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${titleInfo["titleType"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Title Type",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Owner Information
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Owner Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    _buildInfoRow("Primary Owner", "${titleInfo["ownerName"]}"),
                    if (titleInfo["coOwnerName"] != null)
                      _buildInfoRow("Co-Owner", "${titleInfo["coOwnerName"]}"),
                    _buildInfoRow("Registered Address", "${titleInfo["registeredAddress"]}"),
                    _buildInfoRow("Issued Date", "${DateTime.parse(titleInfo["issuedDate"]).dMMMy}"),
                    _buildInfoRow("State", "${titleInfo["state"]}"),
                  ],
                ),
              ),

              // Lien Information
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.account_balance, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Lien Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getTitleStatusColor(titleInfo["lienStatus"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            titleInfo["lienStatus"] == "Paid Off" ? Icons.check_circle : Icons.account_balance,
                            color: _getTitleStatusColor(titleInfo["lienStatus"]),
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Status: ${titleInfo["lienStatus"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _getTitleStatusColor(titleInfo["lienStatus"]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (titleInfo["previousLien"] != null)
                      _buildInfoRow("Previous Lienholder", "${titleInfo["previousLien"]}"),
                    if (titleInfo["lienReleaseDate"] != null)
                      _buildInfoRow("Lien Release Date", "${DateTime.parse(titleInfo["lienReleaseDate"]).dMMMy}"),
                  ],
                ),
              ),

              // Fee Information
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.receipt, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Fee Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    _buildInfoRow("Title Fees", "\$${(titleInfo["titleFees"] as double).currency}"),
                    _buildInfoRow("Registration Fees", "\$${(titleInfo["registrationFees"] as double).currency}"),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Total Fees Paid:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "\$${(titleInfo["totalFees"] as double).currency}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
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
                      label: "Download Title",
                      icon: Icons.download,
                      size: bs.md,
                      onPressed: () {
                        ss("Downloading title document...");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Print Title",
                      icon: Icons.print,
                      size: bs.md,
                      onPressed: () {
                        ss("Preparing title for printing...");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Title History Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ...titleHistory.map((record) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: record["status"] == "Completed" ? successColor : warningColor,
                      ),
                    ),
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (record["status"] == "Completed" ? successColor : warningColor).withAlpha(40),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              record["status"] == "Completed" ? Icons.check : Icons.hourglass_empty,
                              size: 16,
                              color: record["status"] == "Completed" ? successColor : warningColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${record["action"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${DateTime.parse(record["date"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${record["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      if ((record["fee"] as double) > 0)
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              "Fee: \$${(record["fee"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),

        // Documents Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Required Documents",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ...requiredDocuments.map((doc) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: _getDocumentStatusColor(doc["status"]).withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          doc["status"] == "Verified" ? Icons.check_circle :
                          doc["status"] == "Pending" ? Icons.hourglass_empty :
                          doc["status"] == "Missing" ? Icons.error :
                          Icons.info,
                          size: 20,
                          color: _getDocumentStatusColor(doc["status"]),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${doc["document"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                if (doc["required"])
                                  Container(
                                    margin: EdgeInsets.only(left: spXs),
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: dangerColor.withAlpha(40),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "REQUIRED",
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        color: dangerColor,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Text(
                              "${doc["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getDocumentStatusColor(doc["status"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${doc["status"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: _getDocumentStatusColor(doc["status"]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),

              Container(
                width: double.infinity,
                child: QButton(
                  label: "Upload Documents",
                  icon: Icons.upload,
                  size: bs.md,
                  onPressed: () {
                    ss("Opening document upload...");
                  },
                ),
              ),
            ],
          ),
        ),

        // Transfer Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: warningColor.withAlpha(60)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.warning, color: warningColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Title Transfer",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Complete this section when selling or transferring ownership of your vehicle. Ensure all information is accurate before submitting.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                "Transfer Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    QTextField(
                      label: "New Owner Name",
                      value: "",
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "New Owner Address",
                      value: "",
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    QNumberField(
                      label: "Sale Price",
                      value: "",
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    QDatePicker(
                      label: "Sale Date",
                      value: DateTime.now(),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    QNumberField(
                      label: "Current Mileage",
                      value: "",
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(60)),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: infoColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Transfer Fees",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    _buildInfoRow("Title Transfer Fee", "\$75.00"),
                    _buildInfoRow("Registration Fee", "\$45.50"),
                    _buildInfoRow("Processing Fee", "\$25.00"),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Total Estimated Fees:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "\$145.50",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                child: QButton(
                  label: "Start Transfer Process",
                  icon: Icons.swap_horiz,
                  size: bs.md,
                  onPressed: () {
                    ss("Starting title transfer process...");
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
