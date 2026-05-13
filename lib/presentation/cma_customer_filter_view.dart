import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCustomerFilterView extends StatefulWidget {
  const CmaCustomerFilterView({super.key});

  @override
  State<CmaCustomerFilterView> createState() => _CmaCustomerFilterViewState();
}

class _CmaCustomerFilterViewState extends State<CmaCustomerFilterView> {
  String selectedStatus = "";
  String selectedCategory = "";
  String selectedSegment = "";
  String selectedTag = "";
  String dateFrom = "";
  String dateTo = "";
  String minOrderValue = "";
  String maxOrderValue = "";
  String selectedRegion = "";
  String selectedSource = "";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "Prospect", "value": "prospect"},
    {"label": "Lead", "value": "lead"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": ""},
    {"label": "Premium", "value": "premium"},
    {"label": "Standard", "value": "standard"},
    {"label": "Basic", "value": "basic"},
    {"label": "VIP", "value": "vip"},
  ];

  List<Map<String, dynamic>> segmentOptions = [
    {"label": "All Segments", "value": ""},
    {"label": "Enterprise", "value": "enterprise"},
    {"label": "SMB", "value": "smb"},
    {"label": "Startup", "value": "startup"},
    {"label": "Individual", "value": "individual"},
  ];

  List<Map<String, dynamic>> tagOptions = [
    {"label": "All Tags", "value": ""},
    {"label": "High Value", "value": "high_value"},
    {"label": "Loyal Customer", "value": "loyal"},
    {"label": "New Customer", "value": "new"},
    {"label": "At Risk", "value": "at_risk"},
  ];

  List<Map<String, dynamic>> regionOptions = [
    {"label": "All Regions", "value": ""},
    {"label": "North America", "value": "north_america"},
    {"label": "Europe", "value": "europe"},
    {"label": "Asia Pacific", "value": "asia_pacific"},
    {"label": "Latin America", "value": "latin_america"},
  ];

  List<Map<String, dynamic>> sourceOptions = [
    {"label": "All Sources", "value": ""},
    {"label": "Website", "value": "website"},
    {"label": "Referral", "value": "referral"},
    {"label": "Social Media", "value": "social"},
    {"label": "Email Campaign", "value": "email"},
    {"label": "Cold Call", "value": "cold_call"},
  ];

  void _applyFilters() {
    ss("Filters applied successfully");
    back();
  }

  void _resetFilters() {
    setState(() {
      selectedStatus = "";
      selectedCategory = "";
      selectedSegment = "";
      selectedTag = "";
      dateFrom = "";
      dateTo = "";
      minOrderValue = "";
      maxOrderValue = "";
      selectedRegion = "";
      selectedSource = "";
    });
    si("All filters have been reset");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Filters"),
        actions: [
          TextButton(
            onPressed: _resetFilters,
            child: Text(
              "Reset",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.filter_list,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Apply filters to find specific customers",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            Text(
              "Customer Status & Category",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
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
                    label: "Category",
                    items: categoryOptions,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
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
                    label: "Segment",
                    items: segmentOptions,
                    value: selectedSegment,
                    onChanged: (value, label) {
                      selectedSegment = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Tag",
                    items: tagOptions,
                    value: selectedTag,
                    onChanged: (value, label) {
                      selectedTag = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Text(
              "Date Range",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QDatePicker(
                    label: "From Date",
                    value: dateFrom.isNotEmpty ? DateTime.parse(dateFrom) : null,
                    onChanged: (value) {
                      dateFrom = value.toIso8601String() ?? "";
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDatePicker(
                    label: "To Date",
                    value: dateTo.isNotEmpty ? DateTime.parse(dateTo) : null,
                    onChanged: (value) {
                      dateTo = value.toIso8601String() ?? "";
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Text(
              "Order Value Range",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QNumberField(
                    label: "Min Order Value (\$)",
                    value: minOrderValue,
                    onChanged: (value) {
                      minOrderValue = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QNumberField(
                    label: "Max Order Value (\$)",
                    value: maxOrderValue,
                    onChanged: (value) {
                      maxOrderValue = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Text(
              "Location & Source",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Region",
                    items: regionOptions,
                    value: selectedRegion,
                    onChanged: (value, label) {
                      selectedRegion = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Source",
                    items: sourceOptions,
                    value: selectedSource,
                    onChanged: (value, label) {
                      selectedSource = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Container(
              width: double.infinity,
              child: QButton(
                label: "Apply Filters",
                onPressed: _applyFilters,
              ),
            ),

            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Active Filters Summary",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  if (selectedStatus.isNotEmpty)
                    Text("• Status: ${statusOptions.firstWhere((item) => item["value"] == selectedStatus)["label"]}", 
                      style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                  if (selectedCategory.isNotEmpty)
                    Text("• Category: ${categoryOptions.firstWhere((item) => item["value"] == selectedCategory)["label"]}", 
                      style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                  if (selectedSegment.isNotEmpty)
                    Text("• Segment: ${segmentOptions.firstWhere((item) => item["value"] == selectedSegment)["label"]}", 
                      style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                  if (selectedTag.isNotEmpty)
                    Text("• Tag: ${tagOptions.firstWhere((item) => item["value"] == selectedTag)["label"]}", 
                      style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                  if (dateFrom.isNotEmpty || dateTo.isNotEmpty)
                    Text("• Date Range: ${dateFrom.isNotEmpty ? dateFrom.substring(0, 10) : 'Start'} - ${dateTo.isNotEmpty ? dateTo.substring(0, 10) : 'End'}", 
                      style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                  if (minOrderValue.isNotEmpty || maxOrderValue.isNotEmpty)
                    Text("• Order Value: \$${minOrderValue.isNotEmpty ? minOrderValue : '0'} - \$${maxOrderValue.isNotEmpty ? maxOrderValue : '∞'}", 
                      style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                  if (selectedRegion.isNotEmpty)
                    Text("• Region: ${regionOptions.firstWhere((item) => item["value"] == selectedRegion)["label"]}", 
                      style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                  if (selectedSource.isNotEmpty)
                    Text("• Source: ${sourceOptions.firstWhere((item) => item["value"] == selectedSource)["label"]}", 
                      style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                  if ([selectedStatus, selectedCategory, selectedSegment, selectedTag, dateFrom, dateTo, minOrderValue, maxOrderValue, selectedRegion, selectedSource].every((filter) => filter.isEmpty))
                    Text("No active filters", style: TextStyle(fontSize: 12, color: disabledColor)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
