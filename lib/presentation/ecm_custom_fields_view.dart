import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmCustomFieldsView extends StatefulWidget {
  const EcmCustomFieldsView({super.key});

  @override
  State<EcmCustomFieldsView> createState() => _EcmCustomFieldsViewState();
}

class _EcmCustomFieldsViewState extends State<EcmCustomFieldsView> {
  bool isLoading = false;
  String searchQuery = "";

  List<Map<String, dynamic>> customFields = [
    {
      "id": 1,
      "name": "Preferred Session Track",
      "label": "Select your preferred session track",
      "type": "dropdown",
      "required": true,
      "placeholder": "Choose a track",
      "options": ["Technology", "Business", "Marketing", "Design"],
      "help_text": "Select the track that best matches your interests",
      "status": "active",
      "created_date": "2025-01-15",
      "usage_count": 156,
      "category": "preferences"
    },
    {
      "id": 2,
      "name": "Years of Experience", 
      "label": "How many years of experience do you have?",
      "type": "number",
      "required": false,
      "placeholder": "Enter number of years",
      "options": [],
      "help_text": "This helps us tailor content to your experience level",
      "status": "active",
      "created_date": "2025-01-12",
      "usage_count": 134,
      "category": "professional"
    },
    {
      "id": 3,
      "name": "Special Dietary Requirements",
      "label": "Do you have any special dietary requirements?",
      "type": "textarea",
      "required": false,
      "placeholder": "Please describe any dietary restrictions or allergies",
      "options": [],
      "help_text": "Help us ensure we can accommodate your dietary needs",
      "status": "active",
      "created_date": "2025-01-10",
      "usage_count": 89,
      "category": "catering"
    },
    {
      "id": 4,
      "name": "Transportation Method",
      "label": "How will you be arriving at the event?",
      "type": "radio",
      "required": true,
      "placeholder": "",
      "options": ["Car", "Public Transport", "Walking", "Bike", "Other"],
      "help_text": "This helps us plan parking and logistics",
      "status": "active",
      "created_date": "2025-01-08",
      "usage_count": 201,
      "category": "logistics"
    },
    {
      "id": 5,
      "name": "Additional Sessions Interest",
      "label": "Which additional sessions would you like to attend?",
      "type": "checkbox",
      "required": false,
      "placeholder": "",
      "options": ["Networking Lunch", "Workshop A", "Workshop B", "Panel Discussion", "Closing Reception"],
      "help_text": "Select all that apply - some may have additional fees",
      "status": "active",
      "created_date": "2025-01-05",
      "usage_count": 78,
      "category": "sessions"
    },
    {
      "id": 6,
      "name": "Company Website",
      "label": "Company website URL",
      "type": "url",
      "required": false,
      "placeholder": "https://example.com",
      "options": [],
      "help_text": "Optional - for networking purposes",
      "status": "draft",
      "created_date": "2025-01-20",
      "usage_count": 0,
      "category": "professional"
    },
    {
      "id": 7,
      "name": "Emergency Contact Email",
      "label": "Emergency contact email address",
      "type": "email",
      "required": true,
      "placeholder": "emergency@example.com",
      "options": [],
      "help_text": "Required for safety and emergency purposes",
      "status": "active",
      "created_date": "2025-01-18",
      "usage_count": 167,
      "category": "emergency"
    },
    {
      "id": 8,
      "name": "Birth Date",
      "label": "Date of birth",
      "type": "date",
      "required": false,
      "placeholder": "Select date",
      "options": [],
      "help_text": "For age verification and special birthday recognition",
      "status": "inactive",
      "created_date": "2025-01-03",
      "usage_count": 45,
      "category": "personal"
    }
  ];

  List<Map<String, dynamic>> get filteredFields {
    if (searchQuery.isEmpty) return customFields;
    return customFields.where((field) {
      return field["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
             field["label"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
             field["category"].toString().toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  Widget _buildCustomFieldCard(Map<String, dynamic> field) {
    Color statusColor = field["status"] == "active" 
        ? successColor 
        : field["status"] == "draft" 
            ? warningColor 
            : disabledBoldColor;
    
    Color typeColor = _getTypeColor(field["type"]);
    Color categoryColor = _getCategoryColor(field["category"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: categoryColor,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spSm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: typeColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(
                    _getTypeIcon(field["type"]),
                    color: typeColor,
                    size: 20,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${field["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: typeColor.withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${field["type"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: typeColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: categoryColor.withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${field["category"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: categoryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${field["status"]}".toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Text(
              "${field["label"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            if (field["help_text"] != null && field["help_text"].toString().isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: spXs),
                child: Text(
                  "${field["help_text"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
              ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(
                  field["required"] == true ? Icons.star : Icons.star_border,
                  size: 16,
                  color: field["required"] == true ? dangerColor : disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Text(
                  field["required"] == true ? "Required field" : "Optional field",
                  style: TextStyle(
                    fontSize: 12,
                    color: field["required"] == true ? dangerColor : disabledBoldColor,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.analytics, color: infoColor, size: 14),
                      SizedBox(width: spXs),
                      Text(
                        "${field["usage_count"]} responses",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if ((field["options"] as List).isNotEmpty) ...[
              SizedBox(height: spSm),
              Text(
                "Options:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Wrap(
                spacing: spXs,
                runSpacing: spXs,
                children: (field["options"] as List).map<Widget>((option) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(26),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "$option",
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
            if (field["placeholder"] != null && field["placeholder"].toString().isNotEmpty) ...[
              SizedBox(height: spSm),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: disabledColor),
                ),
                child: Text(
                  "Placeholder: ${field["placeholder"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
            SizedBox(height: spSm),
            Row(
              children: [
                Text(
                  "Created: ${DateTime.parse(field["created_date"]).dMMMy}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Edit",
                  size: bs.sm,
                  onPressed: () => _editField(field),
                ),
                SizedBox(width: spXs),
                QButton(
                  icon: Icons.copy,
                  size: bs.sm,
                  onPressed: () => _duplicateField(field),
                ),
                SizedBox(width: spXs),
                QButton(
                  icon: field["status"] == "active" ? Icons.pause : Icons.play_arrow,
                  size: bs.sm,
                  onPressed: () => _toggleFieldStatus(field),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldPreview(Map<String, dynamic> field) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
              Icon(Icons.preview, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Field Preview: ${field["name"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          _buildFieldWidget(field),
        ],
      ),
    );
  }

  Widget _buildFieldWidget(Map<String, dynamic> field) {
    String fieldType = field["type"];
    String label = field["label"];
    bool required = field["required"] ?? false;
    String placeholder = field["placeholder"] ?? "";
    List<String> options = (field["options"] as List<dynamic>).cast<String>();

    switch (fieldType) {
      case "text":
        return QTextField(
          label: required ? "$label *" : label,
          value: "",
          hint: placeholder,
          onChanged: (value) {},
        );
      
      case "email":
        return QTextField(
          label: required ? "$label *" : label,
          value: "",
          hint: placeholder,
          onChanged: (value) {},
        );
      
      case "url":
        return QTextField(
          label: required ? "$label *" : label,
          value: "",
          hint: placeholder,
          onChanged: (value) {},
        );
      
      case "number":
        return QNumberField(
          label: required ? "$label *" : label,
          value: "",
          onChanged: (value) {},
        );
      
      case "textarea":
        return QMemoField(
          label: required ? "$label *" : label,
          value: "",
          hint: placeholder,
          onChanged: (value) {},
        );
      
      case "dropdown":
        List<Map<String, dynamic>> dropdownItems = options.map((option) => {
          "label": option,
          "value": option,
        }).toList();
        return QDropdownField(
          label: required ? "$label *" : label,
          items: dropdownItems,
          value: "",
          onChanged: (value, label) {},
        );
      
      case "radio":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              required ? "$label *" : label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            ...options.map((option) {
              return Container(
                margin: EdgeInsets.only(bottom: spXs),
                child: Row(
                  children: [
                    Radio(
                      value: option,
                      groupValue: null,
                      onChanged: (value) {},
                    ),
                    Text(
                      option,
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        );
      
      case "checkbox":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              required ? "$label *" : label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            ...options.map((option) {
              return Container(
                margin: EdgeInsets.only(bottom: spXs),
                child: Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (value) {},
                    ),
                    Text(
                      option,
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        );
      
      case "date":
        return QDatePicker(
          label: required ? "$label *" : label,
          value: DateTime.now(),
          onChanged: (value) {},
        );
      
      default:
        return QTextField(
          label: required ? "$label *" : label,
          value: "",
          hint: placeholder,
          onChanged: (value) {},
        );
    }
  }

  Widget _buildSummaryCard() {
    int totalFields = customFields.length;
    int activeFields = customFields.where((field) => field["status"] == "active").length;
    int requiredFields = customFields.where((field) => field["required"] == true).length;
    int totalResponses = customFields.fold(0, (sum, field) => sum + (field["usage_count"] as int));

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Custom Fields Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.dynamic_form, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Total Fields",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$totalFields",
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
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Active Fields",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$activeFields",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: dangerColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Required",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$requiredFields",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.analytics, color: infoColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Responses",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$totalResponses",
                      style: TextStyle(
                        fontSize: 20,
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
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "text":
      case "email":
      case "url":
        return primaryColor;
      case "number":
        return successColor;
      case "textarea":
        return infoColor;
      case "dropdown":
      case "radio":
        return warningColor;
      case "checkbox":
        return secondaryColor;
      case "date":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "text":
        return Icons.text_fields;
      case "email":
        return Icons.email;
      case "url":
        return Icons.link;
      case "number":
        return Icons.numbers;
      case "textarea":
        return Icons.notes;
      case "dropdown":
        return Icons.arrow_drop_down;
      case "radio":
        return Icons.radio_button_checked;
      case "checkbox":
        return Icons.check_box;
      case "date":
        return Icons.calendar_today;
      default:
        return Icons.input;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "preferences":
        return primaryColor;
      case "professional":
        return successColor;
      case "catering":
        return warningColor;
      case "logistics":
        return infoColor;
      case "sessions":
        return secondaryColor;
      case "emergency":
        return dangerColor;
      case "personal":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  void _editField(Map<String, dynamic> field) {
    // Navigate to edit field
  }

  void _duplicateField(Map<String, dynamic> field) {
    // Duplicate field
  }

  void _toggleFieldStatus(Map<String, dynamic> field) {
    // Toggle field status
  }

  void _createNewField() {
    // Navigate to create new field
  }

  void _filterFields() {
    // Show filter options
  }

  void _previewField(Map<String, dynamic> field) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Field Preview"),
        content: _buildFieldPreview(field),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Fields"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: _createNewField,
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: spSm),
                        Icon(Icons.search, color: disabledBoldColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search custom fields...",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: disabledBoldColor),
                            ),
                            onChanged: (value) {
                              searchQuery = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: _filterFields,
                ),
              ],
            ),
            SizedBox(height: spSm),
            _buildSummaryCard(),
            SizedBox(height: spSm),
            Text(
              "Custom Fields (${filteredFields.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            if (isLoading)
              Center(child: CircularProgressIndicator())
            else
              ...filteredFields.map((field) => GestureDetector(
                onTap: () => _previewField(field),
                child: _buildCustomFieldCard(field),
              )).toList(),
          ],
        ),
      ),
    );
  }
}
