import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlImport3View extends StatefulWidget {
  @override
  State<GrlImport3View> createState() => _GrlImport3ViewState();
}

class _GrlImport3ViewState extends State<GrlImport3View> {
  bool isLoading = false;
  String validationProgress = "";
  double progressValue = 0.0;
  
  List<Map<String, dynamic>> validationResults = [
    {
      "rule": "Required Fields",
      "description": "Check for missing required data",
      "status": "passed",
      "errors": 0,
      "warnings": 0,
      "checked": 15420
    },
    {
      "rule": "Email Format",
      "description": "Validate email address format",
      "status": "warning",
      "errors": 0,
      "warnings": 45,
      "checked": 15420
    },
    {
      "rule": "Phone Number Format",
      "description": "Validate phone number format",
      "status": "error",
      "errors": 23,
      "warnings": 12,
      "checked": 15420
    },
    {
      "rule": "Date Format",
      "description": "Validate date and datetime fields",
      "status": "passed",
      "errors": 0,
      "warnings": 0,
      "checked": 15420
    },
    {
      "rule": "Duplicate Records",
      "description": "Check for duplicate entries",
      "status": "warning",
      "errors": 0,
      "warnings": 156,
      "checked": 15420
    },
    {
      "rule": "Data Length",
      "description": "Check field length constraints",
      "status": "error",
      "errors": 8,
      "warnings": 0,
      "checked": 15420
    },
    {
      "rule": "Foreign Key Constraints",
      "description": "Validate reference integrity",
      "status": "passed",
      "errors": 0,
      "warnings": 0,
      "checked": 15420
    }
  ];

  List<Map<String, dynamic>> detailedIssues = [
    {
      "row": 1245,
      "field": "phone",
      "issue": "Invalid phone number format",
      "value": "555-INVALID",
      "severity": "error",
      "suggestion": "Use format: +1-555-123-4567"
    },
    {
      "row": 2890,
      "field": "email",
      "issue": "Email format suspicious",
      "value": "user@domain..com",
      "severity": "warning",
      "suggestion": "Check for double dots in domain"
    },
    {
      "row": 3456,
      "field": "firstName",
      "issue": "Field length exceeds limit",
      "value": "VeryLongFirstNameThatExceedsLimit...",
      "severity": "error",
      "suggestion": "Maximum 50 characters allowed"
    },
    {
      "row": 4567,
      "field": "email",
      "issue": "Duplicate email address",
      "value": "john.doe@example.com",
      "severity": "warning",
      "suggestion": "Email appears in row 892"
    },
    {
      "row": 5678,
      "field": "phone",
      "issue": "Missing country code",
      "value": "555-123-4567",
      "severity": "warning",
      "suggestion": "Consider adding country code"
    },
    {
      "row": 6789,
      "field": "lastName",
      "issue": "Field length exceeds limit",
      "value": "VeryLongLastNameThatExceedsTheM...",
      "severity": "error",
      "suggestion": "Maximum 50 characters allowed"
    }
  ];

  String selectedSeverity = "all";
  List<String> severityOptions = ["all", "error", "warning"];

  List<Map<String, dynamic>> get filteredIssues {
    if (selectedSeverity == "all") return detailedIssues;
    return detailedIssues.where((issue) => issue["severity"] == selectedSeverity).toList();
  }

  int get totalErrors {
    return validationResults.fold(0, (sum, result) => sum + (result["errors"] as int));
  }

  int get totalWarnings {
    return validationResults.fold(0, (sum, result) => sum + (result["warnings"] as int));
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'passed':
        return successColor;
      case 'warning':
        return warningColor;
      case 'error':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case 'error':
        return dangerColor;
      case 'warning':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'passed':
        return Icons.check_circle;
      case 'warning':
        return Icons.warning;
      case 'error':
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  Future<void> _runValidation() async {
    isLoading = true;
    progressValue = 0.0;
    setState(() {});

    List<String> steps = [
      "Initializing validation engine...",
      "Checking required fields...", 
      "Validating email formats...",
      "Checking phone numbers...",
      "Validating dates...",
      "Detecting duplicates...",
      "Checking field lengths...",
      "Validating constraints...",
      "Generating report...",
      "Validation completed!"
    ];

    for (int i = 0; i < steps.length; i++) {
      await Future.delayed(Duration(milliseconds: 800));
      validationProgress = steps[i];
      progressValue = (i + 1) / steps.length;
      setState(() {});
    }

    isLoading = false;
    validationProgress = "";
    progressValue = 0.0;
    setState(() {});
    
    ss("Data validation completed");
  }

  Future<void> _exportReport() async {
    bool isConfirmed = await confirm("Export validation report to file?");
    if (!isConfirmed) return;

    // Simulate export
    await Future.delayed(Duration(seconds: 1));
    ss("Validation report exported successfully");
  }

  Future<void> _autoFixIssues() async {
    bool isConfirmed = await confirm("Automatically fix correctable issues?");
    if (!isConfirmed) return;

    // Simulate auto-fix
    await Future.delayed(Duration(seconds: 2));
    
    // Remove some auto-fixable issues
    detailedIssues.removeWhere((issue) => 
        issue["issue"].toString().contains("Missing country code") ||
        issue["issue"].toString().contains("Email format suspicious"));
    
    setState(() {});
    ss("Auto-fix completed - Some issues have been resolved");
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> displayIssues = filteredIssues;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Validation"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _exportReport,
          ),
          IconButton(
            icon: Icon(Icons.auto_fix_high),
            onPressed: detailedIssues.isNotEmpty ? _autoFixIssues : null,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Validation Progress
            if (isLoading)
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
                                "Validating Data",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                validationProgress,
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

            // Validation Summary
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
                        "Validation Summary",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: isLoading ? "Validating..." : "Run Validation",
                        icon: Icons.play_arrow,
                        size: bs.sm,
                        onPressed: isLoading ? null : _runValidation,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: dangerColor.withAlpha(30)),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.error,
                                color: dangerColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                totalErrors.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Errors",
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
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: warningColor.withAlpha(30)),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.warning,
                                color: warningColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                totalWarnings.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Warnings",
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
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: successColor.withAlpha(30)),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: successColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "15,420",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Records",
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
            ),

            // Validation Rules
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
                    "Validation Rules",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...validationResults.map((result) {
                    String status = "${result["status"]}";
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: _getStatusColor(status).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 4,
                            color: _getStatusColor(status),
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(
                                _getStatusIcon(status),
                                color: _getStatusColor(status),
                                size: 20,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${result["rule"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${result["description"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: spXxs,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(status),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  status.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              if ((result["errors"] as int) > 0) ...[
                                Icon(
                                  Icons.error,
                                  size: 14,
                                  color: dangerColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${result["errors"]} errors",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spSm),
                              ],
                              if ((result["warnings"] as int) > 0) ...[
                                Icon(
                                  Icons.warning,
                                  size: 14,
                                  color: warningColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${result["warnings"]} warnings",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: warningColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spSm),
                              ],
                              Icon(
                                Icons.check,
                                size: 14,
                                color: successColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${result["checked"]} checked",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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

            // Detailed Issues
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
                        "Detailed Issues",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 120,
                        child: QDropdownField(
                          label: "Filter",
                          items: [
                            {"label": "All Issues", "value": "all"},
                            {"label": "Errors Only", "value": "error"},
                            {"label": "Warnings Only", "value": "warning"},
                          ],
                          value: selectedSeverity,
                          onChanged: (value, label) {
                            selectedSeverity = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  if (displayIssues.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 48,
                            color: successColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No Issues Found",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Your data looks good!",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...displayIssues.map((issue) {
                      String severity = "${issue["severity"]}";
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: _getSeverityColor(severity).withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 3,
                              color: _getSeverityColor(severity),
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: spXxs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getSeverityColor(severity),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    severity.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Row ${issue["row"]} • ${issue["field"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${issue["issue"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "Value: ${issue["value"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),
                            if ((issue["suggestion"] as String).isNotEmpty)
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.lightbulb,
                                      size: 14,
                                      color: infoColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "${issue["suggestion"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: infoColor,
                                          fontStyle: FontStyle.italic,
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
                ],
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    icon: Icons.file_download,
                    size: bs.md,
                    onPressed: _exportReport,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Auto Fix",
                    icon: Icons.auto_fix_high,
                    size: bs.md,
                    onPressed: detailedIssues.isNotEmpty ? _autoFixIssues : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
