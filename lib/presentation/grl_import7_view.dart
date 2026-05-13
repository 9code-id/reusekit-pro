import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlImport7View extends StatefulWidget {
  @override
  State<GrlImport7View> createState() => _GrlImport7ViewState();
}

class _GrlImport7ViewState extends State<GrlImport7View> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  
  String mappingName = "";
  String sourceField = "";
  String targetField = "";
  String transformationType = "None";
  String customScript = "";
  String validationRule = "";
  String defaultValue = "";
  bool isRequired = false;
  
  List<Map<String, dynamic>> fieldMappings = [
    {
      "id": "1",
      "source": "first_name",
      "target": "firstName",
      "transformation": "Capitalize",
      "validation": "Required",
      "default": "",
      "type": "String",
      "status": "active",
    },
    {
      "id": "2", 
      "source": "email_address",
      "target": "email",
      "transformation": "Lowercase",
      "validation": "Email Format",
      "default": "",
      "type": "String",
      "status": "active",
    },
    {
      "id": "3",
      "source": "birth_date",
      "target": "dateOfBirth",
      "transformation": "Date Format",
      "validation": "Date Range",
      "default": "1900-01-01",
      "type": "Date",
      "status": "active",
    },
    {
      "id": "4",
      "source": "phone_number",
      "target": "phoneNumber",
      "transformation": "Format Phone",
      "validation": "Phone Format",
      "default": "",
      "type": "String",
      "status": "inactive",
    },
    {
      "id": "5",
      "source": "salary",
      "target": "annualSalary",
      "transformation": "Multiply by 12",
      "validation": "Numeric Range",
      "default": "0",
      "type": "Number",
      "status": "active",
    }
  ];

  List<Map<String, dynamic>> sourceFields = [
    {"label": "first_name", "value": "first_name"},
    {"label": "last_name", "value": "last_name"},
    {"label": "email_address", "value": "email_address"},
    {"label": "phone_number", "value": "phone_number"},
    {"label": "birth_date", "value": "birth_date"},
    {"label": "address", "value": "address"},
    {"label": "city", "value": "city"},
    {"label": "country", "value": "country"},
    {"label": "salary", "value": "salary"},
    {"label": "join_date", "value": "join_date"},
  ];

  List<Map<String, dynamic>> targetFields = [
    {"label": "firstName", "value": "firstName"},
    {"label": "lastName", "value": "lastName"},
    {"label": "email", "value": "email"},
    {"label": "phoneNumber", "value": "phoneNumber"},
    {"label": "dateOfBirth", "value": "dateOfBirth"},
    {"label": "fullAddress", "value": "fullAddress"},
    {"label": "city", "value": "city"},
    {"label": "country", "value": "country"},
    {"label": "annualSalary", "value": "annualSalary"},
    {"label": "employmentDate", "value": "employmentDate"},
  ];

  List<Map<String, dynamic>> transformationOptions = [
    {"label": "None", "value": "None"},
    {"label": "Uppercase", "value": "Uppercase"},
    {"label": "Lowercase", "value": "Lowercase"},
    {"label": "Capitalize", "value": "Capitalize"},
    {"label": "Trim Spaces", "value": "Trim"},
    {"label": "Date Format", "value": "Date Format"},
    {"label": "Number Format", "value": "Number Format"},
    {"label": "Custom Script", "value": "Custom"},
  ];

  List<Map<String, dynamic>> validationOptions = [
    {"label": "None", "value": "None"},
    {"label": "Required", "value": "Required"},
    {"label": "Email Format", "value": "Email"},
    {"label": "Phone Format", "value": "Phone"},
    {"label": "Date Range", "value": "Date Range"},
    {"label": "Numeric Range", "value": "Numeric Range"},
    {"label": "Custom Validation", "value": "Custom"},
  ];

  void _addFieldMapping() {
    if (!formKey.currentState!.validate()) return;
    
    final newMapping = {
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "source": sourceField,
      "target": targetField,
      "transformation": transformationType,
      "validation": validationRule,
      "default": defaultValue,
      "type": _getFieldType(targetField),
      "status": "active",
    };
    
    fieldMappings.add(newMapping);
    
    // Reset form
    sourceField = "";
    targetField = "";
    transformationType = "None";
    validationRule = "";
    defaultValue = "";
    isRequired = false;
    
    setState(() {});
    ss("Field mapping added successfully");
  }

  void _removeFieldMapping(String id) async {
    bool isConfirmed = await confirm("Are you sure you want to remove this field mapping?");
    if (!isConfirmed) return;
    
    fieldMappings.removeWhere((mapping) => mapping["id"] == id);
    setState(() {});
    sw("Field mapping removed");
  }

  void _toggleMappingStatus(String id) {
    final index = fieldMappings.indexWhere((mapping) => mapping["id"] == id);
    if (index != -1) {
      fieldMappings[index]["status"] = 
          fieldMappings[index]["status"] == "active" ? "inactive" : "active";
      setState(() {});
    }
  }

  void _testMapping() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    si("Mapping test completed. 3 warnings found, 0 errors.");
  }

  void _saveMapping() async {
    if (mappingName.isEmpty) {
      se("Please enter a mapping name");
      return;
    }
    
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 1));
    
    loading = false;
    setState(() {});
    
    ss("Field mapping '$mappingName' saved successfully");
  }

  String _getFieldType(String fieldName) {
    if (fieldName.contains("Date") || fieldName.contains("date")) return "Date";
    if (fieldName.contains("salary") || fieldName.contains("amount")) return "Number";
    if (fieldName.contains("email")) return "Email";
    if (fieldName.contains("phone")) return "Phone";
    return "String";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Field Mapping Editor"),
        actions: [
          Icon(
            Icons.transform,
            color: primaryColor,
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMappingHeaderSection(),
                  _buildAddMappingSection(),
                  _buildMappingListSection(),
                  _buildMappingActionsSection(),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildMappingHeaderSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.settings,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Mapping Configuration",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Mapping Name",
            value: mappingName,
            hint: "Enter a descriptive name for this mapping",
            validator: Validator.required,
            onChanged: (value) {
              mappingName = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: successColor.withAlpha(100)),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.input,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Source Fields",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "${sourceFields.length} available",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.arrow_forward,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: infoColor.withAlpha(100)),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.output,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Target Fields",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "${targetFields.length} available", 
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
    );
  }

  Widget _buildAddMappingSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.add_circle,
                color: successColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Add Field Mapping",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Source Field",
                  items: sourceFields,
                  value: sourceField,
                  validator: Validator.required,
                  onChanged: (value, label) {
                    sourceField = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Target Field",
                  items: targetFields,
                  value: targetField,
                  validator: Validator.required,
                  onChanged: (value, label) {
                    targetField = value;
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
                  label: "Transformation",
                  items: transformationOptions,
                  value: transformationType,
                  onChanged: (value, label) {
                    transformationType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Validation Rule",
                  items: validationOptions,
                  value: validationRule,
                  onChanged: (value, label) {
                    validationRule = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          if (transformationType == "Custom")
            QMemoField(
              label: "Custom Script",
              value: customScript,
              hint: "Enter JavaScript code for custom transformation",
              onChanged: (value) {
                customScript = value;
                setState(() {});
              },
            ),
          QTextField(
            label: "Default Value (Optional)",
            value: defaultValue,
            hint: "Value to use when source field is empty",
            onChanged: (value) {
              defaultValue = value;
              setState(() {});
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add Mapping",
              size: bs.sm,
              onPressed: _addFieldMapping,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMappingListSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.list,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Field Mappings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "${fieldMappings.where((m) => m["status"] == "active").length}/${fieldMappings.length}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (fieldMappings.isEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  Icon(
                    Icons.map,
                    color: disabledColor,
                    size: 48,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No field mappings configured",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Add field mappings to define how data should be transformed",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            ...fieldMappings.map((mapping) => _buildMappingCard(mapping)),
        ],
      ),
    );
  }

  Widget _buildMappingCard(Map<String, dynamic> mapping) {
    bool active = mapping["status"] == "active";
    Color statusColor = active ? successColor : disabledBoldColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: active ? statusColor.withAlpha(50) : disabledColor,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: active ? statusColor.withAlpha(100) : disabledBoldColor,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  active ? Icons.check_circle : Icons.pause_circle,
                  color: Colors.white,
                  size: 20,
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
                          "${mapping["source"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: statusColor,
                          size: 16,
                        ),
                        Text(
                          "${mapping["target"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${mapping["type"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        if (mapping["transformation"] != "None")
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${mapping["transformation"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        SizedBox(width: spXs),
                        if (mapping["validation"] != "None")
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${mapping["validation"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert,
                  color: disabledBoldColor,
                  size: 16,
                ),
                onSelected: (value) {
                  switch (value) {
                    case 'toggle':
                      _toggleMappingStatus(mapping["id"]);
                      break;
                    case 'remove':
                      _removeFieldMapping(mapping["id"]);
                      break;
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'toggle',
                    child: Row(
                      children: [
                        Icon(
                          active ? Icons.pause : Icons.play_arrow,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(active ? "Disable" : "Enable"),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'remove',
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 16),
                        SizedBox(width: spXs),
                        Text("Remove"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (mapping["default"] != null && mapping["default"].toString().isNotEmpty)
            Container(
              margin: EdgeInsets.only(top: spXs),
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.settings,
                    color: infoColor,
                    size: 12,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Default: ${mapping["default"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMappingActionsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.build,
                color: warningColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Mapping Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Test Mapping",
                  size: bs.sm,
                  onPressed: fieldMappings.isEmpty ? null : _testMapping,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Save Configuration",
                  size: bs.sm,
                  onPressed: _saveMapping,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(100)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mapping Tips",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "• Test your mappings before running the import\n• Use transformations to format data consistently\n• Set default values for required fields\n• Validate data to prevent import errors",
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
        ],
      ),
    );
  }
}
