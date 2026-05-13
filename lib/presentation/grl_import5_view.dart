import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlImport5View extends StatefulWidget {
  @override
  State<GrlImport5View> createState() => _GrlImport5ViewState();
}

class _GrlImport5ViewState extends State<GrlImport5View> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  int currentStep = 0;
  
  // Step 1: Source Selection
  String selectedSource = "Database";
  String connectionString = "";
  String username = "";
  String password = "";
  String databaseName = "";
  
  // Step 2: Query Configuration
  String queryType = "SELECT";
  String customQuery = "";
  String selectedTable = "";
  List<String> selectedFields = [];
  String whereCondition = "";
  
  // Step 3: Import Settings
  int batchSize = 1000;
  bool useTransaction = true;
  String conflictResolution = "Skip";
  bool logErrors = true;
  
  // Step 4: Scheduling
  bool scheduleImport = false;
  String scheduleFrequency = "Daily";
  String scheduleTime = "09:00";

  List<Map<String, dynamic>> sourceOptions = [
    {"label": "MySQL Database", "value": "MySQL"},
    {"label": "PostgreSQL", "value": "PostgreSQL"},
    {"label": "SQL Server", "value": "SQL Server"},
    {"label": "Oracle", "value": "Oracle"},
    {"label": "MongoDB", "value": "MongoDB"},
    {"label": "REST API", "value": "REST API"},
  ];

  List<Map<String, dynamic>> queryTypeOptions = [
    {"label": "SELECT Query", "value": "SELECT"},
    {"label": "Stored Procedure", "value": "PROCEDURE"},
    {"label": "Custom Query", "value": "CUSTOM"},
  ];

  List<Map<String, dynamic>> tableOptions = [
    {"label": "users", "value": "users"},
    {"label": "products", "value": "products"},
    {"label": "orders", "value": "orders"},
    {"label": "customers", "value": "customers"},
    {"label": "transactions", "value": "transactions"},
  ];

  List<Map<String, dynamic>> availableFields = [
    {"label": "ID", "value": "id", "checked": true},
    {"label": "Name", "value": "name", "checked": true},
    {"label": "Email", "value": "email", "checked": true},
    {"label": "Phone", "value": "phone", "checked": false},
    {"label": "Created Date", "value": "created_at", "checked": true},
    {"label": "Updated Date", "value": "updated_at", "checked": false},
    {"label": "Status", "value": "status", "checked": true},
  ];

  List<Map<String, dynamic>> conflictOptions = [
    {"label": "Skip Duplicates", "value": "Skip"},
    {"label": "Update Existing", "value": "Update"},
    {"label": "Replace All", "value": "Replace"},
    {"label": "Fail on Conflict", "value": "Fail"},
  ];

  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Daily", "value": "Daily"},
    {"label": "Weekly", "value": "Weekly"},
    {"label": "Monthly", "value": "Monthly"},
    {"label": "Custom", "value": "Custom"},
  ];

  @override
  void initState() {
    super.initState();
    selectedFields = availableFields
        .where((field) => field["checked"] == true)
        .map((field) => field["value"].toString())
        .toList();
  }

  void _nextStep() {
    if (currentStep < 3) {
      currentStep++;
      setState(() {});
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      currentStep--;
      setState(() {});
    }
  }

  void _testConnection() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Database connection successful!");
  }

  void _previewData() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    si("Preview: 1,234 records found matching your criteria");
  }

  void _startImport() async {
    if (!formKey.currentState!.validate()) return;
    
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 4));
    
    loading = false;
    setState(() {});
    
    ss("Import completed successfully! 1,234 records imported.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Database Import Wizard"),
        actions: [
          Icon(
            Icons.storage,
            color: primaryColor,
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: loading 
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: spMd),
                Text(
                  "Processing import operation...",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          )
        : Form(
            key: formKey,
            child: Column(
              children: [
                _buildStepIndicator(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(spMd),
                    child: _buildCurrentStep(),
                  ),
                ),
                _buildNavigationButtons(),
              ],
            ),
          ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: List.generate(4, (index) {
          bool isActive = index == currentStep;
          bool isCompleted = index < currentStep;
          
          return Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    if (index > 0)
                      Expanded(
                        child: Container(
                          height: 2,
                          color: isCompleted ? successColor : disabledColor,
                        ),
                      ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isCompleted ? successColor : 
                               isActive ? primaryColor : disabledColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: isCompleted 
                          ? Icon(Icons.check, color: Colors.white, size: 16)
                          : Text(
                              "${index + 1}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      ),
                    ),
                    if (index < 3)
                      Expanded(
                        child: Container(
                          height: 2,
                          color: isCompleted ? successColor : disabledColor,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  _getStepTitle(index),
                  style: TextStyle(
                    fontSize: 12,
                    color: isActive ? primaryColor : disabledBoldColor,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  String _getStepTitle(int index) {
    switch (index) {
      case 0: return "Source";
      case 1: return "Query";
      case 2: return "Settings";
      case 3: return "Schedule";
      default: return "";
    }
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0: return _buildSourceStep();
      case 1: return _buildQueryStep();
      case 2: return _buildSettingsStep();
      case 3: return _buildScheduleStep();
      default: return Container();
    }
  }

  Widget _buildSourceStep() {
    return Column(
      spacing: spMd,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Configure Data Source",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            children: [
              QDropdownField(
                label: "Database Type",
                items: sourceOptions,
                value: selectedSource,
                validator: Validator.required,
                onChanged: (value, label) {
                  selectedSource = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Connection String",
                value: connectionString,
                hint: "server=localhost;database=mydb;",
                validator: Validator.required,
                onChanged: (value) {
                  connectionString = value;
                  setState(() {});
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Username",
                      value: username,
                      validator: Validator.required,
                      onChanged: (value) {
                        username = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Password",
                      value: password,
                      obscureText: true,
                      validator: Validator.required,
                      onChanged: (value) {
                        password = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              QTextField(
                label: "Database Name",
                value: databaseName,
                validator: Validator.required,
                onChanged: (value) {
                  databaseName = value;
                  setState(() {});
                },
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Test Connection",
                  size: bs.sm,
                  onPressed: _testConnection,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQueryStep() {
    return Column(
      spacing: spMd,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Configure Data Query",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            children: [
              QDropdownField(
                label: "Query Type",
                items: queryTypeOptions,
                value: queryType,
                onChanged: (value, label) {
                  queryType = value;
                  setState(() {});
                },
              ),
              if (queryType == "SELECT") ...[
                QDropdownField(
                  label: "Select Table",
                  items: tableOptions,
                  value: selectedTable,
                  validator: Validator.required,
                  onChanged: (value, label) {
                    selectedTable = value;
                    setState(() {});
                  },
                ),
                Text(
                  "Select Fields",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                QSwitch(
                  items: availableFields,
                  value: availableFields
                      .where((field) => selectedFields.contains(field["value"]))
                      .toList(),
                  onChanged: (values, ids) {
                    selectedFields = values.map((v) => v["value"].toString()).toList();
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "WHERE Condition (Optional)",
                  value: whereCondition,
                  hint: "e.g., status = 'active' AND created_at > '2024-01-01'",
                  onChanged: (value) {
                    whereCondition = value;
                    setState(() {});
                  },
                ),
              ],
              if (queryType == "CUSTOM") 
                QMemoField(
                  label: "Custom SQL Query",
                  value: customQuery,
                  hint: "Enter your custom SQL query here...",
                  validator: Validator.required,
                  onChanged: (value) {
                    customQuery = value;
                    setState(() {});
                  },
                ),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Preview Data",
                      size: bs.sm,
                      onPressed: _previewData,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Validate Query",
                      size: bs.sm,
                      onPressed: () {
                        si("Query syntax is valid");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsStep() {
    return Column(
      spacing: spMd,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Import Settings",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            children: [
              QNumberField(
                label: "Batch Size",
                value: batchSize.toString(),
                hint: "Number of records per batch",
                validator: Validator.required,
                onChanged: (value) {
                  batchSize = int.tryParse(value) ?? 1000;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Conflict Resolution",
                items: conflictOptions,
                value: conflictResolution,
                onChanged: (value, label) {
                  conflictResolution = value;
                  setState(() {});
                },
              ),
              QSwitch(
                items: [
                  {
                    "label": "Use Database Transaction",
                    "value": "transaction",
                    "checked": useTransaction,
                  },
                  {
                    "label": "Log Import Errors",
                    "value": "logging",
                    "checked": logErrors,
                  }
                ],
                value: [
                  if (useTransaction)
                    {"label": "Use Database Transaction", "value": "transaction", "checked": true},
                  if (logErrors)
                    {"label": "Log Import Errors", "value": "logging", "checked": true},
                ],
                onChanged: (values, ids) {
                  useTransaction = values.any((v) => v["value"] == "transaction");
                  logErrors = values.any((v) => v["value"] == "logging");
                  setState(() {});
                },
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: infoColor.withAlpha(100)),
                ),
                child: Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: infoColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Import Performance Tips",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "• Larger batch sizes improve performance but use more memory\n• Transactions ensure data consistency but may slow down imports\n• Error logging helps troubleshoot failed imports",
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
    );
  }

  Widget _buildScheduleStep() {
    return Column(
      spacing: spMd,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Schedule Import",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            children: [
              QSwitch(
                items: [
                  {
                    "label": "Schedule Recurring Import",
                    "value": true,
                    "checked": scheduleImport,
                  }
                ],
                value: [
                  if (scheduleImport)
                    {"label": "Schedule Recurring Import", "value": true, "checked": true}
                ],
                onChanged: (values, ids) {
                  scheduleImport = values.isNotEmpty;
                  setState(() {});
                },
              ),
              if (scheduleImport) ...[
                QDropdownField(
                  label: "Frequency",
                  items: frequencyOptions,
                  value: scheduleFrequency,
                  onChanged: (value, label) {
                    scheduleFrequency = value;
                    setState(() {});
                  },
                ),
                QTimePicker(
                  label: "Start Time",
                  value: scheduleTime.timeOfDay,
                  onChanged: (value) {
                    scheduleTime = value!.kkmm;
                    setState(() {});
                  },
                ),
              ],
              _buildSummary(),
              Container(
                width: double.infinity,
                child: QButton(
                  label: scheduleImport ? "Schedule Import" : "Start Import Now",
                  size: bs.md,
                  onPressed: _startImport,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummary() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: successColor.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: successColor.withAlpha(100)),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Import Summary",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          _buildSummaryRow("Source", "$selectedSource Database"),
          _buildSummaryRow("Table", selectedTable.isNotEmpty ? selectedTable : "Custom Query"),
          _buildSummaryRow("Fields", "${selectedFields.length} selected"),
          _buildSummaryRow("Batch Size", "$batchSize records"),
          _buildSummaryRow("Conflicts", conflictResolution),
          if (scheduleImport)
            _buildSummaryRow("Schedule", "$scheduleFrequency at $scheduleTime"),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      children: [
        Container(
          width: 80,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ),
        Text(
          ": ",
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: successColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          if (currentStep > 0)
            Expanded(
              child: QButton(
                label: "Previous",
                size: bs.sm,
                onPressed: _previousStep,
              ),
            ),
          if (currentStep > 0 && currentStep < 3)
            SizedBox(width: spSm),
          if (currentStep < 3)
            Expanded(
              child: QButton(
                label: "Next",
                size: bs.sm,
                onPressed: _nextStep,
              ),
            ),
        ],
      ),
    );
  }
}
