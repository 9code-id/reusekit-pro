import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlScanner6View extends StatefulWidget {
  @override
  State<GrlScanner6View> createState() => _GrlScanner6ViewState();
}

class _GrlScanner6ViewState extends State<GrlScanner6View> {
  String qrText = "https://flutter.dev";
  String selectedType = "URL";
  String selectedSize = "Medium";
  Color selectedColor = Colors.black;
  
  List<Map<String, dynamic>> qrTypes = [
    {"label": "URL", "value": "URL", "icon": Icons.link},
    {"label": "WiFi", "value": "WiFi", "icon": Icons.wifi},
    {"label": "Contact", "value": "Contact", "icon": Icons.person},
    {"label": "Text", "value": "Text", "icon": Icons.text_fields},
    {"label": "Email", "value": "Email", "icon": Icons.email},
    {"label": "Phone", "value": "Phone", "icon": Icons.phone},
  ];
  
  List<String> sizeOptions = ["Small", "Medium", "Large", "Extra Large"];
  List<Color> colorOptions = [
    Colors.black,
    primaryColor,
    successColor,
    dangerColor,
    warningColor,
    infoColor,
  ];
  
  // WiFi specific fields
  String wifiSSID = "";
  String wifiPassword = "";
  String wifiSecurity = "WPA";
  
  // Contact specific fields
  String contactName = "";
  String contactPhone = "";
  String contactEmail = "";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code Generator"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("QR Code saved to gallery");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // QR Code Preview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Text(
                    "QR Code Preview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    width: _getQRSize(),
                    height: _getQRSize(),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.qr_code,
                          color: Colors.white,
                          size: _getQRSize() * 0.6,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    _getPreviewText(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            
            // QR Type Selector
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "QR Code Type",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 100,
                    children: qrTypes.map((type) {
                      bool isSelected = selectedType == type["value"];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedType = type["value"];
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor.withAlpha(20) : disabledColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Column(
                            spacing: spXs,
                            children: [
                              Icon(
                                type["icon"],
                                color: isSelected ? primaryColor : disabledBoldColor,
                                size: 24,
                              ),
                              Text(
                                "${type["label"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            // Content Input
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Content",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  _buildContentFields(),
                ],
              ),
            ),
            
            // Customization Options
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Customization",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  // Size Selection
                  QDropdownField(
                    label: "Size",
                    items: sizeOptions.map((size) => {
                      "label": size,
                      "value": size,
                    }).toList(),
                    value: selectedSize,
                    onChanged: (value, label) {
                      selectedSize = value;
                      setState(() {});
                    },
                  ),
                  
                  // Color Selection
                  Text(
                    "Color",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: colorOptions.map((color) {
                      bool isSelected = selectedColor == color;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedColor = color;
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: isSelected ? Colors.white : Colors.transparent,
                              width: 3,
                            ),
                            boxShadow: isSelected ? [shadowMd] : null,
                          ),
                          child: isSelected
                              ? Icon(Icons.check, color: Colors.white, size: 20)
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Generate",
                    size: bs.md,
                    onPressed: () {
                      ss("QR Code generated successfully");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Share",
                    size: bs.md,
                    onPressed: () {
                      ss("QR Code shared");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildContentFields() {
    switch (selectedType) {
      case "WiFi":
        return Column(
          spacing: spSm,
          children: [
            QTextField(
              label: "Network Name (SSID)",
              value: wifiSSID,
              onChanged: (value) {
                wifiSSID = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "Password",
              value: wifiPassword,
              onChanged: (value) {
                wifiPassword = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Security",
              items: [
                {"label": "WPA", "value": "WPA"},
                {"label": "WEP", "value": "WEP"},
                {"label": "None", "value": "None"},
              ],
              value: wifiSecurity,
              onChanged: (value, label) {
                wifiSecurity = value;
                setState(() {});
              },
            ),
          ],
        );
      
      case "Contact":
        return Column(
          spacing: spSm,
          children: [
            QTextField(
              label: "Name",
              value: contactName,
              onChanged: (value) {
                contactName = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "Phone",
              value: contactPhone,
              onChanged: (value) {
                contactPhone = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "Email",
              value: contactEmail,
              onChanged: (value) {
                contactEmail = value;
                setState(() {});
              },
            ),
          ],
        );
      
      default:
        return QMemoField(
          label: _getFieldLabel(),
          value: qrText,
          hint: _getFieldHint(),
          onChanged: (value) {
            qrText = value;
            setState(() {});
          },
        );
    }
  }
  
  String _getFieldLabel() {
    switch (selectedType) {
      case "URL":
        return "Website URL";
      case "Email":
        return "Email Address";
      case "Phone":
        return "Phone Number";
      default:
        return "Text Content";
    }
  }
  
  String _getFieldHint() {
    switch (selectedType) {
      case "URL":
        return "https://example.com";
      case "Email":
        return "user@example.com";
      case "Phone":
        return "+1234567890";
      default:
        return "Enter your text here";
    }
  }
  
  String _getPreviewText() {
    switch (selectedType) {
      case "WiFi":
        return wifiSSID.isNotEmpty ? "WiFi: $wifiSSID" : "WiFi Network";
      case "Contact":
        return contactName.isNotEmpty ? "Contact: $contactName" : "Contact Info";
      default:
        return qrText.isNotEmpty ? qrText : "QR Code Content";
    }
  }
  
  double _getQRSize() {
    switch (selectedSize) {
      case "Small":
        return 120;
      case "Medium":
        return 160;
      case "Large":
        return 200;
      case "Extra Large":
        return 240;
      default:
        return 160;
    }
  }
}
