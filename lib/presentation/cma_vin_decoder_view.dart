import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaVinDecoderView extends StatefulWidget {
  const CmaVinDecoderView({super.key});

  @override
  State<CmaVinDecoderView> createState() => _CmaVinDecoderViewState();
}

class _CmaVinDecoderViewState extends State<CmaVinDecoderView> {
  String vinNumber = "";
  bool isDecoding = false;
  bool hasDecoded = false;
  
  Map<String, dynamic>? decodedData;

  void _decodeVin() async {
    if (vinNumber.length != 17) {
      se("VIN must be exactly 17 characters");
      return;
    }

    isDecoding = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    decodedData = {
      "vin": vinNumber,
      "year": "2023",
      "make": "Toyota",
      "model": "Camry",
      "trim": "LE",
      "engine": "2.5L 4-Cylinder",
      "transmission": "8-Speed Automatic",
      "drivetrain": "Front-Wheel Drive",
      "bodyStyle": "4-Door Sedan",
      "fuelType": "Gasoline",
      "manufacturingPlant": "Georgetown, Kentucky",
      "countryOfOrigin": "United States",
      "modelYear": "2023",
      "serialNumber": "123456",
      "checkDigit": "1",
      "worldManufacturerIdentifier": "4T1",
      "vehicleDescriptorSection": "BF1FK5",
      "vehicleIdentifierSection": "1234567",
      "restraintSystem": "Airbags - Front, Side, Curtain",
      "gvwr": "4,680 lbs",
      "engineDisplacement": "2.5L",
      "enginePower": "203 HP",
      "fuelEconomy": "28 City / 39 Highway MPG",
      "safetyRating": "5-Star Overall",
      "recallCount": 2,
      "warrantyStatus": "Active",
      "isFleetVehicle": false,
      "isPreviouslyOwned": true,
      "manufactureDate": "2023-02-15",
      "firstSaleDate": "2023-03-01"
    };

    isDecoding = false;
    hasDecoded = true;
    setState(() {});
    
    ss("VIN decoded successfully!");
  }

  void _clearDecoding() {
    vinNumber = "";
    decodedData = null;
    hasDecoded = false;
    setState(() {});
  }

  Widget _buildInfoRow(String label, String value, {IconData? icon, Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: primaryColor),
            SizedBox(width: spXs),
          ],
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
                color: valueColor ?? Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(String title, List<Widget> children, {IconData? icon, Color? color}) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: color != null ? Border.all(color: color.withAlpha(60)) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: color ?? primaryColor, size: 20),
                SizedBox(width: spSm),
              ],
              Text(
                title,
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: color ?? primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...children,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("VIN Decoder"),
        actions: [
          if (hasDecoded)
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: _clearDecoding,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // VIN Input Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(60)),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.qr_code_scanner, color: primaryColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Enter VIN Number",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QTextField(
                    label: "VIN (17 characters)",
                    value: vinNumber,
                    hint: "Enter 17-character VIN number",
                    onChanged: (value) {
                      vinNumber = value.toUpperCase();
                      setState(() {});
                    },
                  ),
                  Text(
                    "Enter the 17-character Vehicle Identification Number found on your dashboard, door frame, or registration documents.",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: isDecoding ? "Decoding..." : "Decode VIN",
                          icon: isDecoding ? Icons.hourglass_empty : Icons.search,
                          size: bs.md,
                          onPressed: isDecoding ? () {} : _decodeVin,
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.qr_code_scanner,
                        size: bs.md,
                        onPressed: () {
                          si("Camera scanner feature coming soon");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            if (isDecoding)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    CircularProgressIndicator(color: primaryColor),
                    SizedBox(height: spSm),
                    Text(
                      "Decoding VIN...",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),

            if (hasDecoded && decodedData != null) ...[
              // Basic Vehicle Information
              _buildSectionCard(
                "Basic Information",
                [
                  _buildInfoRow("VIN", "${decodedData!["vin"]}", icon: Icons.confirmation_number),
                  _buildInfoRow("Year", "${decodedData!["year"]}", icon: Icons.calendar_today),
                  _buildInfoRow("Make", "${decodedData!["make"]}", icon: Icons.business),
                  _buildInfoRow("Model", "${decodedData!["model"]}", icon: Icons.directions_car),
                  _buildInfoRow("Trim", "${decodedData!["trim"]}", icon: Icons.star),
                  _buildInfoRow("Body Style", "${decodedData!["bodyStyle"]}", icon: Icons.category),
                ],
                icon: Icons.info,
              ),

              // Engine & Performance
              _buildSectionCard(
                "Engine & Performance",
                [
                  _buildInfoRow("Engine", "${decodedData!["engine"]}", icon: Icons.settings),
                  _buildInfoRow("Power", "${decodedData!["enginePower"]}", icon: Icons.flash_on, valueColor: warningColor),
                  _buildInfoRow("Transmission", "${decodedData!["transmission"]}", icon: Icons.swap_horiz),
                  _buildInfoRow("Drivetrain", "${decodedData!["drivetrain"]}", icon: Icons.drive_eta),
                  _buildInfoRow("Fuel Type", "${decodedData!["fuelType"]}", icon: Icons.local_gas_station),
                  _buildInfoRow("Fuel Economy", "${decodedData!["fuelEconomy"]}", icon: Icons.eco, valueColor: successColor),
                ],
                icon: Icons.engineering,
                color: warningColor,
              ),

              // Manufacturing Details
              _buildSectionCard(
                "Manufacturing Details",
                [
                  _buildInfoRow("Manufacturing Plant", "${decodedData!["manufacturingPlant"]}", icon: Icons.factory),
                  _buildInfoRow("Country of Origin", "${decodedData!["countryOfOrigin"]}", icon: Icons.flag),
                  _buildInfoRow("Manufacture Date", "${DateTime.parse(decodedData!["manufactureDate"]).dMMMy}", icon: Icons.build),
                  _buildInfoRow("First Sale Date", "${DateTime.parse(decodedData!["firstSaleDate"]).dMMMy}", icon: Icons.sell),
                  _buildInfoRow("Serial Number", "${decodedData!["serialNumber"]}", icon: Icons.numbers),
                  _buildInfoRow("Check Digit", "${decodedData!["checkDigit"]}", icon: Icons.verified),
                ],
                icon: Icons.precision_manufacturing,
                color: infoColor,
              ),

              // VIN Breakdown
              _buildSectionCard(
                "VIN Breakdown",
                [
                  _buildInfoRow("World Manufacturer ID", "${decodedData!["worldManufacturerIdentifier"]}", valueColor: primaryColor),
                  _buildInfoRow("Vehicle Descriptor", "${decodedData!["vehicleDescriptorSection"]}", valueColor: primaryColor),
                  _buildInfoRow("Vehicle Identifier", "${decodedData!["vehicleIdentifierSection"]}", valueColor: primaryColor),
                ],
                icon: Icons.code,
                color: primaryColor,
              ),

              // Safety & Specifications
              _buildSectionCard(
                "Safety & Specifications",
                [
                  _buildInfoRow("Safety Rating", "${decodedData!["safetyRating"]}", icon: Icons.shield, valueColor: successColor),
                  _buildInfoRow("Restraint System", "${decodedData!["restraintSystem"]}", icon: Icons.security),
                  _buildInfoRow("GVWR", "${decodedData!["gvwr"]}", icon: Icons.monitor_weight),
                  _buildInfoRow("Recall Count", "${decodedData!["recallCount"]}", icon: Icons.warning, 
                    valueColor: (decodedData!["recallCount"] as int) > 0 ? dangerColor : successColor),
                ],
                icon: Icons.verified_user,
                color: successColor,
              ),

              // Vehicle Status
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
                    Row(
                      children: [
                        Icon(Icons.assignment, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Vehicle Status",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (decodedData!["isFleetVehicle"] as bool) ? warningColor.withAlpha(20) : successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  (decodedData!["isFleetVehicle"] as bool) ? Icons.business : Icons.person,
                                  color: (decodedData!["isFleetVehicle"] as bool) ? warningColor : successColor,
                                  size: 24,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  (decodedData!["isFleetVehicle"] as bool) ? "Fleet Vehicle" : "Personal Use",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: (decodedData!["isFleetVehicle"] as bool) ? warningColor : successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (decodedData!["isPreviouslyOwned"] as bool) ? infoColor.withAlpha(20) : successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  (decodedData!["isPreviouslyOwned"] as bool) ? Icons.repeat : Icons.new_releases,
                                  color: (decodedData!["isPreviouslyOwned"] as bool) ? infoColor : successColor,
                                  size: 24,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  (decodedData!["isPreviouslyOwned"] as bool) ? "Pre-Owned" : "New Vehicle",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: (decodedData!["isPreviouslyOwned"] as bool) ? infoColor : successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.verified,
                                  color: successColor,
                                  size: 24,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${decodedData!["warrantyStatus"]}",
                                  style: TextStyle(
                                    fontSize: 12,
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

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Save Report",
                      icon: Icons.save,
                      size: bs.md,
                      onPressed: () {
                        ss("VIN report saved successfully");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Share Report",
                      icon: Icons.share,
                      size: bs.md,
                      onPressed: () {
                        ss("Sharing VIN report...");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
