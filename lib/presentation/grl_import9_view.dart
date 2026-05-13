import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlImport9View extends StatefulWidget {
  @override
  State<GrlImport9View> createState() => _GrlImport9ViewState();
}

class _GrlImport9ViewState extends State<GrlImport9View> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  
  String templateName = "";
  String templateDescription = "";
  String templateCategory = "General";
  bool isPublic = false;
  
  List<Map<String, dynamic>> templateFields = [
    {
      "id": "1",
      "name": "id",
      "label": "Record ID",
      "type": "Number",
      "required": true,
      "defaultValue": "",
      "validation": "Unique",
      "order": 1,
    },
    {
      "id": "2",
      "name": "name",
      "label": "Full Name",
      "type": "String",
      "required": true,
      "defaultValue": "",
      "validation": "Required",
      "order": 2,
    },
    {
      "id": "3",
      "name": "email",
      "label": "Email Address",
      "type": "Email",
      "required": true,
      "defaultValue": "",
      "validation": "Email Format",
      "order": 3,
    }
  ];

  List<Map<String, dynamic>> savedTemplates = [
    {
      "id": "TPL001",
      "name": "Customer Data Template",
      "description": "Standard customer information import",
      "category": "Customer",
      "fields": 12,
      "downloads": 156,
      "lastModified": DateTime.now().subtract(Duration(days: 2)),
      "isPublic": true,
      "author": "admin@company.com",
    },
    {
      "id": "TPL002",
      "name": "Product Inventory Template",
      "description": "Product catalog and inventory management",
      "category": "Inventory",
      "fields": 8,
      "downloads": 89,
      "lastModified": DateTime.now().subtract(Duration(days: 5)),
      "isPublic": false,
      "author": "inventory@company.com",
    },
    {
      "id": "TPL003",
      "name": "Employee Records Template",
      "description": "HR employee data import template",
      "category": "HR",
      "fields": 15,
      "downloads": 67,
      "lastModified": DateTime.now().subtract(Duration(days: 10)),
      "isPublic": true,
      "author": "hr@company.com",
    }
  ];

  String fieldName = "";
  String fieldLabel = "";
  String fieldType = "String";
  bool fieldRequired = false;
  String fieldDefaultValue = "";
  String fieldValidation = "None";

  List<Map<String, dynamic>> fieldTypes = [
    {"label": "String", "value": "String"},
    {"label": "Number", "value": "Number"},
    {"label": "Date", "value": "Date"},
    {"label": "Email", "value": "Email"},
    {"label": "Phone", "value": "Phone"},
    {"label": "Boolean", "value": "Boolean"},
    {"label": "URL", "value": "URL"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "General", "value": "General"},
    {"label": "Customer", "value": "Customer"},
    {"label": "Inventory", "value": "Inventory"},
    {"label": "HR", "value": "HR"},
    {"label": "Finance", "value": "Finance"},
    {"label": "Sales", "value": "Sales"},
  ];

  List<Map<String, dynamic>> validationOptions = [
    {"label": "None", "value": "None"},
    {"label": "Required", "value": "Required"},
    {"label": "Unique", "value": "Unique"},
    {"label": "Email Format", "value": "Email Format"},
    {"label": "Phone Format", "value": "Phone Format"},
    {"label": "Date Range", "value": "Date Range"},
    {"label": "Numeric Range", "value": "Numeric Range"},
  ];

  void _addField() {
    if (fieldName.isEmpty || fieldLabel.isEmpty) {
      se("Please fill in field name and label");
      return;
    }
    
    final newField = {
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "name": fieldName,
      "label": fieldLabel,
      "type": fieldType,
      "required": fieldRequired,
      "defaultValue": fieldDefaultValue,
      "validation": fieldValidation,
      "order": templateFields.length + 1,
    };
    
    templateFields.add(newField);
    
    // Reset form
    fieldName = "";
    fieldLabel = "";
    fieldType = "String";
    fieldRequired = false;
    fieldDefaultValue = "";
    fieldValidation = "None";
    
    setState(() {});
    ss("Field added successfully");
  }

  void _removeField(String id) async {
    bool isConfirmed = await confirm("Are you sure you want to remove this field?");
    if (!isConfirmed) return;
    
    templateFields.removeWhere((field) => field["id"] == id);
    
    // Reorder remaining fields
    for (int i = 0; i < templateFields.length; i++) {
      templateFields[i]["order"] = i + 1;
    }
    
    setState(() {});
    sw("Field removed successfully");
  }

  void _moveFieldUp(String id) {
    final index = templateFields.indexWhere((field) => field["id"] == id);
    if (index > 0) {
      final field = templateFields.removeAt(index);
      templateFields.insert(index - 1, field);
      
      // Update order numbers
      for (int i = 0; i < templateFields.length; i++) {
        templateFields[i]["order"] = i + 1;
      }
      
      setState(() {});
    }
  }

  void _moveFieldDown(String id) {
    final index = templateFields.indexWhere((field) => field["id"] == id);
    if (index < templateFields.length - 1) {
      final field = templateFields.removeAt(index);
      templateFields.insert(index + 1, field);
      
      // Update order numbers
      for (int i = 0; i < templateFields.length; i++) {
        templateFields[i]["order"] = i + 1;
      }
      
      setState(() {});
    }
  }

  void _saveTemplate() async {
    if (!formKey.currentState!.validate()) return;
    
    if (templateFields.isEmpty) {
      se("Please add at least one field to the template");
      return;
    }
    
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Template '$templateName' saved successfully");
  }

  void _downloadTemplate(String templateId) {
    si("Downloading template $templateId");
  }

  void _duplicateTemplate(String templateId) {
    si("Template $templateId duplicated");
  }

  void _deleteTemplate(String templateId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this template?");
    if (!isConfirmed) return;
    
    savedTemplates.removeWhere((template) => template["id"] == templateId);
    setState(() {});
    sw("Template deleted");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Template Manager"),
        actions: [
          Icon(
            Icons.description,
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
                  _buildTemplateInfoSection(),
                  _buildAddFieldSection(),
                  _buildFieldsListSection(),
                  _buildSavedTemplatesSection(),
                  _buildTemplateActions(),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildTemplateInfoSection() {
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
                Icons.info,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Template Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Template Name",
            value: templateName,
            hint: "Enter a descriptive template name",
            validator: Validator.required,
            onChanged: (value) {
              templateName = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Description",
            value: templateDescription,
            hint: "Describe what this template is used for",
            onChanged: (value) {
              templateDescription = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: templateCategory,
                  onChanged: (value, label) {
                    templateCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Public Template",
                      "value": true,
                      "checked": isPublic,
                    }
                  ],
                  value: [
                    if (isPublic)
                      {"label": "Public Template", "value": true, "checked": true}
                  ],
                  onChanged: (values, ids) {
                    isPublic = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddFieldSection() {
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
                "Add Field",
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
                child: QTextField(
                  label: "Field Name",
                  value: fieldName,
                  hint: "e.g., firstName, email",
                  onChanged: (value) {
                    fieldName = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Field Label",
                  value: fieldLabel,
                  hint: "e.g., First Name, Email Address",
                  onChanged: (value) {
                    fieldLabel = value;
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
                  label: "Field Type",
                  items: fieldTypes,
                  value: fieldType,
                  onChanged: (value, label) {
                    fieldType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Validation",
                  items: validationOptions,
                  value: fieldValidation,
                  onChanged: (value, label) {
                    fieldValidation = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Default Value (Optional)",
                  value: fieldDefaultValue,
                  hint: "Default value for this field",
                  onChanged: (value) {
                    fieldDefaultValue = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Required Field",
                      "value": true,
                      "checked": fieldRequired,
                    }
                  ],
                  value: [
                    if (fieldRequired)
                      {"label": "Required Field", "value": true, "checked": true}
                  ],
                  onChanged: (values, ids) {
                    fieldRequired = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add Field",
              size: bs.sm,
              onPressed: _addField,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldsListSection() {
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
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Template Fields",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: infoColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "${templateFields.length} fields",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (templateFields.isEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  Icon(
                    Icons.view_list,
                    color: disabledColor,
                    size: 48,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No fields configured",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Add fields to define your template structure",
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
            ...templateFields.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> field = entry.value;
              return _buildFieldCard(field, index);
            }),
        ],
      ),
    );
  }

  Widget _buildFieldCard(Map<String, dynamic> field, int index) {
    Color typeColor = _getTypeColor(field["type"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: typeColor.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: typeColor.withAlpha(100)),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: typeColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                "${field["order"]}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                      "${field["label"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: typeColor,
                      ),
                    ),
                    if (field["required"] == true) ...[
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "REQUIRED",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${field["name"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      " • ",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: typeColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${field["type"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (field["validation"] != "None") ...[
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(
                          color: warningColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${field["validation"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              QButton(
                icon: Icons.arrow_upward,
                size: bs.sm,
                onPressed: index == 0 ? null : () => _moveFieldUp(field["id"]),
              ),
              SizedBox(height: spXs),
              QButton(
                icon: Icons.arrow_downward,
                size: bs.sm,
                onPressed: index == templateFields.length - 1 ? null : () => _moveFieldDown(field["id"]),
              ),
            ],
          ),
          SizedBox(width: spXs),
          QButton(
            icon: Icons.delete,
            size: bs.sm,
            onPressed: () => _removeField(field["id"]),
          ),
        ],
      ),
    );
  }

  Widget _buildSavedTemplatesSection() {
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
                Icons.folder,
                color: secondaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Saved Templates",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: secondaryColor,
                ),
              ),
            ],
          ),
          ...savedTemplates.map((template) => _buildSavedTemplateCard(template)),
        ],
      ),
    );
  }

  Widget _buildSavedTemplateCard(Map<String, dynamic> template) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: secondaryColor.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: secondaryColor.withAlpha(100)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              template["isPublic"] ? Icons.public : Icons.lock,
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
                      "${template["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: infoColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${template["category"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${template["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${template["fields"]} fields",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      " • ",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${template["downloads"]} downloads",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      " • ",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(template["lastModified"] as DateTime).dMMMy}",
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
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: disabledBoldColor,
              size: 16,
            ),
            onSelected: (value) {
              switch (value) {
                case 'download':
                  _downloadTemplate(template["id"]);
                  break;
                case 'duplicate':
                  _duplicateTemplate(template["id"]);
                  break;
                case 'delete':
                  _deleteTemplate(template["id"]);
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'download',
                child: Row(
                  children: [
                    Icon(Icons.download, size: 16),
                    SizedBox(width: spXs),
                    Text("Download"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'duplicate',
                child: Row(
                  children: [
                    Icon(Icons.copy, size: 16),
                    SizedBox(width: spXs),
                    Text("Duplicate"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, size: 16),
                    SizedBox(width: spXs),
                    Text("Delete"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateActions() {
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
                "Template Actions",
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
                  label: "Preview Template",
                  size: bs.sm,
                  onPressed: templateFields.isEmpty ? null : () {
                    si("Previewing template with ${templateFields.length} fields");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Save Template",
                  size: bs.md,
                  onPressed: _saveTemplate,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "String": return primaryColor;
      case "Number": return successColor;
      case "Date": return infoColor;
      case "Email": return warningColor;
      case "Phone": return secondaryColor;
      case "Boolean": return dangerColor;
      case "URL": return disabledBoldColor;
      default: return primaryColor;
    }
  }
}
