import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlImport2View extends StatefulWidget {
  @override
  State<GrlImport2View> createState() => _GrlImport2ViewState();
}

class _GrlImport2ViewState extends State<GrlImport2View> {
  bool isLoading = false;
  String mappingProgress = "";
  double progressValue = 0.0;
  String selectedFile = "customers_data.csv";
  
  List<Map<String, dynamic>> sourceColumns = [
    {"name": "customer_id", "type": "integer", "sample": "12345"},
    {"name": "first_name", "type": "string", "sample": "John"},
    {"name": "last_name", "type": "string", "sample": "Smith"},
    {"name": "email_address", "type": "string", "sample": "john.smith@email.com"},
    {"name": "phone_number", "type": "string", "sample": "+1-555-123-4567"},
    {"name": "date_of_birth", "type": "date", "sample": "1985-03-15"},
    {"name": "street_address", "type": "string", "sample": "123 Main Street"},
    {"name": "city_name", "type": "string", "sample": "New York"},
    {"name": "state_code", "type": "string", "sample": "NY"},
    {"name": "postal_code", "type": "string", "sample": "10001"},
    {"name": "country_code", "type": "string", "sample": "US"},
    {"name": "account_status", "type": "string", "sample": "active"},
    {"name": "registration_date", "type": "date", "sample": "2024-01-15"},
    {"name": "last_login", "type": "datetime", "sample": "2024-06-22 14:30:00"}
  ];

  List<Map<String, dynamic>> targetFields = [
    {"name": "id", "type": "integer", "required": true, "mapped": "customer_id"},
    {"name": "firstName", "type": "string", "required": true, "mapped": "first_name"},
    {"name": "lastName", "type": "string", "required": true, "mapped": "last_name"},
    {"name": "email", "type": "string", "required": true, "mapped": "email_address"},
    {"name": "phone", "type": "string", "required": false, "mapped": "phone_number"},
    {"name": "dateOfBirth", "type": "date", "required": false, "mapped": "date_of_birth"},
    {"name": "address", "type": "string", "required": false, "mapped": "street_address"},
    {"name": "city", "type": "string", "required": false, "mapped": "city_name"},
    {"name": "state", "type": "string", "required": false, "mapped": "state_code"},
    {"name": "zipCode", "type": "string", "required": false, "mapped": "postal_code"},
    {"name": "country", "type": "string", "required": false, "mapped": "country_code"},
    {"name": "status", "type": "string", "required": true, "mapped": "account_status"},
    {"name": "createdAt", "type": "datetime", "required": true, "mapped": "registration_date"},
    {"name": "lastLogin", "type": "datetime", "required": false, "mapped": "last_login"}
  ];

  List<Map<String, dynamic>> get availableColumns {
    return sourceColumns.map((col) => {
      "label": "${col["name"]} (${col["type"]})",
      "value": col["name"],
    }).toList()..insert(0, {"label": "-- Not Mapped --", "value": ""});
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'string':
        return primaryColor;
      case 'integer':
        return infoColor;
      case 'date':
      case 'datetime':
        return warningColor;
      case 'boolean':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'string':
        return Icons.text_fields;
      case 'integer':
        return Icons.numbers;
      case 'date':
      case 'datetime':
        return Icons.calendar_today;
      case 'boolean':
        return Icons.check_box;
      default:
        return Icons.help;
    }
  }

  void _updateMapping(int index, String? value) {
    targetFields[index]["mapped"] = value ?? "";
    setState(() {});
  }

  bool _validateMapping() {
    for (var field in targetFields) {
      if (field["required"] == true && (field["mapped"] == null || field["mapped"] == "")) {
        return false;
      }
    }
    return true;
  }

  List<String> _getValidationErrors() {
    List<String> errors = [];
    for (var field in targetFields) {
      if (field["required"] == true && (field["mapped"] == null || field["mapped"] == "")) {
        errors.add("${field["name"]} is required but not mapped");
      }
    }
    return errors;
  }

  Future<void> _autoMapping() async {
    mappingProgress = "Analyzing field names...";
    progressValue = 0.2;
    setState(() {});
    await Future.delayed(Duration(milliseconds: 500));

    mappingProgress = "Detecting patterns...";
    progressValue = 0.5;
    setState(() {});
    await Future.delayed(Duration(milliseconds: 500));

    mappingProgress = "Applying smart mapping...";
    progressValue = 0.8;
    setState(() {});
    await Future.delayed(Duration(milliseconds: 500));

    // Auto-map based on similar names
    for (int i = 0; i < targetFields.length; i++) {
      String targetName = "${targetFields[i]["name"]}".toLowerCase();
      
      // Find best match in source columns
      for (var sourceCol in sourceColumns) {
        String sourceName = "${sourceCol["name"]}".toLowerCase();
        if (sourceName.contains(targetName) || targetName.contains(sourceName) || 
            _isSimilarField(targetName, sourceName)) {
          targetFields[i]["mapped"] = sourceCol["name"];
          break;
        }
      }
    }

    mappingProgress = "Auto-mapping completed!";
    progressValue = 1.0;
    setState(() {});
    await Future.delayed(Duration(milliseconds: 500));

    mappingProgress = "";
    progressValue = 0.0;
    setState(() {});
    
    ss("Auto-mapping completed successfully");
  }

  bool _isSimilarField(String target, String source) {
    Map<String, List<String>> similarFields = {
      'id': ['customer_id', 'user_id', 'account_id'],
      'firstname': ['first_name', 'fname', 'given_name'],
      'lastname': ['last_name', 'lname', 'surname', 'family_name'],
      'email': ['email_address', 'mail', 'e_mail'],
      'phone': ['phone_number', 'telephone', 'mobile'],
      'dateofbirth': ['date_of_birth', 'birth_date', 'dob'],
      'address': ['street_address', 'address_line1', 'addr'],
      'zipcode': ['postal_code', 'zip', 'postcode'],
      'createdat': ['registration_date', 'created_date', 'signup_date']
    };

    for (var entry in similarFields.entries) {
      if (target.contains(entry.key) && entry.value.any((s) => source.contains(s))) {
        return true;
      }
    }
    return false;
  }

  Future<void> _saveMapping() async {
    if (!_validateMapping()) {
      se("Please map all required fields before saving");
      return;
    }

    isLoading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    isLoading = false;
    setState(() {});
    
    ss("Field mapping saved successfully");
  }

  @override
  Widget build(BuildContext context) {
    bool isValid = _validateMapping();
    List<String> errors = _getValidationErrors();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Field Mapping"),
        actions: [
          IconButton(
            icon: Icon(Icons.auto_fix_high),
            onPressed: mappingProgress.isEmpty ? _autoMapping : null,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Auto Mapping Progress
            if (mappingProgress.isNotEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: infoColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: infoColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Auto-Mapping Fields",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                mappingProgress,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${(progressValue * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: progressValue,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(infoColor),
                    ),
                  ],
                ),
              ),

            // File Information
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
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.table_chart,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Source File",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              selectedFile,
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${sourceColumns.length} columns",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Validation Status
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: isValid ? successColor.withAlpha(10) : dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: isValid ? successColor : dangerColor,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        isValid ? Icons.check_circle : Icons.error,
                        color: isValid ? successColor : dangerColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        isValid ? "Mapping Valid" : "Mapping Issues",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isValid ? successColor : dangerColor,
                        ),
                      ),
                    ],
                  ),
                  if (!isValid && errors.isNotEmpty) ...[
                    Text(
                      "Please fix the following issues:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    ...errors.map((error) => Padding(
                      padding: EdgeInsets.only(left: spSm),
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 6,
                            color: dangerColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            error,
                            style: TextStyle(
                              fontSize: 12,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ],
                  if (isValid)
                    Text(
                      "All required fields are mapped correctly",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                ],
              ),
            ),

            // Field Mapping
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
                  Row(
                    children: [
                      Text(
                        "Field Mapping",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Auto Map",
                        icon: Icons.auto_fix_high,
                        size: bs.sm,
                        onPressed: mappingProgress.isEmpty ? _autoMapping : null,
                      ),
                    ],
                  ),
                  Text(
                    "Map source columns to target fields:",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  ...targetFields.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> field = entry.value;
                    bool isRequired = field["required"] as bool;
                    String mappedValue = "${field["mapped"] ?? ""}";
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: isRequired && mappedValue.isEmpty 
                            ? dangerColor.withAlpha(5)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isRequired && mappedValue.isEmpty 
                              ? dangerColor
                              : disabledColor,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: _getTypeColor("${field["type"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  _getTypeIcon("${field["type"]}"),
                                  color: _getTypeColor("${field["type"]}"),
                                  size: 16,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${field["name"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                        if (isRequired) ...[
                                          SizedBox(width: spXs),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: spXxs,
                                            ),
                                            decoration: BoxDecoration(
                                              color: dangerColor,
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "REQUIRED",
                                              style: TextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    Text(
                                      "Type: ${field["type"]}",
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
                          QDropdownField(
                            label: "Map to source column",
                            items: availableColumns,
                            value: mappedValue.isEmpty ? "" : mappedValue,
                            onChanged: (value, label) {
                              _updateMapping(index, value);
                            },
                          ),
                          if (mappedValue.isNotEmpty) ...[
                            SizedBox(height: spXs),
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.preview,
                                    size: 14,
                                    color: infoColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Sample: ",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: infoColor,
                                    ),
                                  ),
                                  Text(
                                    sourceColumns.firstWhere((col) => col["name"] == mappedValue, 
                                        orElse: () => {"sample": "N/A"})["sample"] ?? "N/A",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Source Columns Reference
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
                    "Available Source Columns",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: sourceColumns.map((column) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: _getTypeColor("${column["type"]}").withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: _getTypeColor("${column["type"]}").withAlpha(30)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  _getTypeIcon("${column["type"]}"),
                                  color: _getTypeColor("${column["type"]}"),
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${column["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: _getTypeColor("${column["type"]}"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Type: ${column["type"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Sample: ${column["sample"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Save Mapping Button
            Container(
              width: double.infinity,
              child: QButton(
                label: isLoading ? "Saving..." : "Save Mapping",
                icon: Icons.save,
                size: bs.md,
                onPressed: isLoading ? null : _saveMapping,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
