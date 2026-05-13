import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaMileageTrackingView extends StatefulWidget {
  const AbaMileageTrackingView({super.key});

  @override
  State<AbaMileageTrackingView> createState() => _AbaMileageTrackingViewState();
}

class _AbaMileageTrackingViewState extends State<AbaMileageTrackingView> {
  int selectedTabIndex = 0;
  String startLocation = "";
  String endLocation = "";
  String purpose = "";
  String notes = "";
  double distance = 0.0;
  bool isPersonalVehicle = true;

  List<Map<String, dynamic>> mileageRecords = [
    {
      "id": 1,
      "date": "2024-01-15",
      "startLocation": "Office - Main Branch",
      "endLocation": "Client Site - ABC Corp",
      "distance": 25.4,
      "purpose": "Client Meeting",
      "amount": 14.22,
      "vehicleType": "Personal Vehicle",
      "status": "Approved",
      "notes": "Quarterly business review meeting"
    },
    {
      "id": 2,
      "date": "2024-01-14",
      "startLocation": "Home Office",
      "endLocation": "Conference Center",
      "distance": 18.7,
      "purpose": "Training Session",
      "amount": 10.45,
      "vehicleType": "Company Car",
      "status": "Pending",
      "notes": "Annual compliance training"
    },
    {
      "id": 3,
      "date": "2024-01-12",
      "startLocation": "Office - Downtown",
      "endLocation": "Airport Terminal",
      "distance": 32.1,
      "purpose": "Business Travel",
      "amount": 17.96,
      "vehicleType": "Personal Vehicle",
      "status": "Approved",
      "notes": "Flight to regional conference"
    },
    {
      "id": 4,
      "date": "2024-01-10",
      "startLocation": "Client Site - XYZ Ltd",
      "endLocation": "Office - Main Branch",
      "distance": 15.2,
      "purpose": "Project Delivery",
      "amount": 8.51,
      "vehicleType": "Personal Vehicle",
      "status": "Rejected",
      "notes": "Final project handover meeting"
    }
  ];

  List<Map<String, dynamic>> vehicleOptions = [
    {"label": "Personal Vehicle", "value": true},
    {"label": "Company Car", "value": false}
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Mileage Tracking",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "Track Mileage", icon: Icon(Icons.add_road)),
        Tab(text: "Records", icon: Icon(Icons.list_alt)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildTrackMileageTab(),
        _buildRecordsTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildTrackMileageTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
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
                    Icon(Icons.location_on, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Trip Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                QTextField(
                  label: "Start Location",
                  value: startLocation,
                  hint: "Enter starting point",
                  onChanged: (value) {
                    startLocation = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "End Location",
                  value: endLocation,
                  hint: "Enter destination",
                  onChanged: (value) {
                    endLocation = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Distance (miles)",
                        value: distance.toString(),
                        onChanged: (value) {
                          distance = double.tryParse(value) ?? 0.0;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Rate",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$0.56/mi",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
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
          Container(
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
                    Icon(Icons.directions_car, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Vehicle & Purpose",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                QSwitch(
                  items: vehicleOptions,
                  value: [if (isPersonalVehicle) vehicleOptions[0] else vehicleOptions[1]],
                  onChanged: (values, ids) {
                    isPersonalVehicle = values.isNotEmpty ? values[0]["value"] : true;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Business Purpose",
                  value: purpose,
                  hint: "Client meeting, conference, etc.",
                  onChanged: (value) {
                    purpose = value;
                    setState(() {});
                  },
                ),
                QMemoField(
                  label: "Additional Notes",
                  value: notes,
                  hint: "Optional trip details",
                  onChanged: (value) {
                    notes = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: successColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(Icons.calculate, color: successColor, size: 24),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Estimated Reimbursement",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(distance * 0.56).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Save Mileage Record",
            onPressed: () {
              ss("Mileage record saved successfully");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecordsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total This Month",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "245.8 miles",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: disabledOutlineBorderColor,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Estimated Amount",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$137.65",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ...mileageRecords.map((record) => _buildMileageRecordCard(record)),
        ],
      ),
    );
  }

  Widget _buildMileageRecordCard(Map<String, dynamic> record) {
    Color statusColor = record["status"] == "Approved" 
        ? successColor 
        : record["status"] == "Pending" 
            ? warningColor 
            : dangerColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${record["date"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${record["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.my_location, color: successColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${record["startLocation"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.location_on, color: dangerColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${record["endLocation"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Distance",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${record["distance"]} mi",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                        "Amount",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${record["amount"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
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
                        "Purpose",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${record["purpose"]}",
                        style: TextStyle(
                          fontSize: 14,
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
          if (record["notes"] != null && record["notes"].toString().isNotEmpty)
            Text(
              "${record["notes"]}",
              style: TextStyle(
                fontSize: 13,
                color: disabledBoldColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Edit",
                  size: bs.sm,
                  onPressed: () {
                    si("Edit mileage record");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Delete",
                  size: bs.sm,
                  onPressed: () async {
                    bool isConfirmed = await confirm("Delete this mileage record?");
                    if (isConfirmed) {
                      se("Mileage record deleted");
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
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
                  "Monthly Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.route, color: primaryColor, size: 32),
                            SizedBox(height: spXs),
                            Text(
                              "Total Miles",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "1,247.3",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.attach_money, color: successColor, size: 32),
                            SizedBox(height: spXs),
                            Text(
                              "Total Amount",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$698.49",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Trip Categories",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildCategoryRow("Client Meetings", 156.2, successColor),
                _buildCategoryRow("Business Travel", 89.5, warningColor),
                _buildCategoryRow("Training", 45.3, infoColor),
                _buildCategoryRow("Other", 23.1, disabledBoldColor),
              ],
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
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Vehicle Usage",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildVehicleRow("Personal Vehicle", 85, primaryColor),
                _buildVehicleRow("Company Car", 15, secondaryColor),
              ],
            ),
          ),
          QButton(
            label: "Export Report",
            onPressed: () {
              ss("Mileage report exported successfully");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(String category, double miles, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              category,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
          Text(
            "${miles} mi",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleRow(String vehicle, int percentage, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            vehicle == "Personal Vehicle" ? Icons.directions_car : Icons.business,
            color: color,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vehicle,
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: percentage / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Text(
            "$percentage%",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
