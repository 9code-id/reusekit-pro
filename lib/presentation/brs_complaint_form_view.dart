import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsComplaintFormView extends StatefulWidget {
  const BrsComplaintFormView({super.key});

  @override
  State<BrsComplaintFormView> createState() => _BrsComplaintFormViewState();
}

class _BrsComplaintFormViewState extends State<BrsComplaintFormView> {
  final formKey = GlobalKey<FormState>();
  
  String complaintType = "";
  String subject = "";
  String description = "";
  String contactMethod = "";
  String priority = "";
  bool anonymousComplaint = false;
  List<String> attachedFiles = [];
  
  List<Map<String, dynamic>> complaintTypeItems = [
    {"label": "Service Quality", "value": "service_quality"},
    {"label": "Staff Behavior", "value": "staff_behavior"},
    {"label": "Cleanliness", "value": "cleanliness"},
    {"label": "Booking Issues", "value": "booking_issues"},
    {"label": "Payment Problems", "value": "payment_problems"},
    {"label": "Facility Issues", "value": "facility_issues"},
    {"label": "Other", "value": "other"},
  ];
  
  List<Map<String, dynamic>> contactMethodItems = [
    {"label": "Email", "value": "email"},
    {"label": "Phone Call", "value": "phone"},
    {"label": "SMS", "value": "sms"},
    {"label": "In-App Message", "value": "in_app"},
  ];
  
  List<Map<String, dynamic>> priorityItems = [
    {"label": "Low", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
    {"label": "Urgent", "value": "urgent"},
  ];
  
  List<Map<String, dynamic>> recentComplaints = [
    {
      "id": "CMP001",
      "type": "Service Quality",
      "subject": "Unsatisfactory haircut",
      "status": "In Progress",
      "date": "2024-06-10",
      "priority": "Medium",
    },
    {
      "id": "CMP002", 
      "type": "Staff Behavior",
      "subject": "Rude staff member",
      "status": "Resolved",
      "date": "2024-06-08",
      "priority": "High",
    },
    {
      "id": "CMP003",
      "type": "Booking Issues", 
      "subject": "Appointment cancelled without notice",
      "status": "Under Review",
      "date": "2024-06-05",
      "priority": "High",
    },
  ];
  
  void _submitComplaint() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Complaint submitted successfully. Reference ID: CMP${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}");
      
      // Reset form
      setState(() {
        complaintType = "";
        subject = "";
        description = "";
        contactMethod = "";
        priority = "";
        anonymousComplaint = false;
        attachedFiles.clear();
      });
    }
  }
  
  void _attachFile() {
    // Simulate file attachment
    setState(() {
      attachedFiles.add("complaint_evidence_${attachedFiles.length + 1}.jpg");
    });
    ss("File attached successfully");
  }
  
  void _removeFile(int index) {
    setState(() {
      attachedFiles.removeAt(index);
    });
  }
  
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'resolved':
        return successColor;
      case 'in progress':
        return warningColor;
      case 'under review':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
  
  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'urgent':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'medium':
        return infoColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Submit Complaint"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Complaint Type Section
              Container(
                padding: EdgeInsets.all(spSm),
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
                        Icon(Icons.report_problem, color: dangerColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Complaint Details",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    QDropdownField(
                      label: "Complaint Type",
                      items: complaintTypeItems,
                      value: complaintType,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        complaintType = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Subject",
                      value: subject,
                      hint: "Brief description of your complaint",
                      validator: Validator.required,
                      onChanged: (value) {
                        subject = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Detailed Description",
                      value: description,
                      hint: "Please provide detailed information about your complaint...",
                      validator: Validator.required,
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Priority and Contact Section
              Container(
                padding: EdgeInsets.all(spSm),
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
                        Icon(Icons.settings, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Additional Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Priority Level",
                            items: priorityItems,
                            value: priority,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              priority = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Preferred Contact Method",
                            items: contactMethodItems,
                            value: contactMethod,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              contactMethod = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Submit as anonymous complaint",
                          "value": true,
                          "checked": anonymousComplaint,
                        }
                      ],
                      value: [
                        if (anonymousComplaint)
                          {
                            "label": "Submit as anonymous complaint",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        setState(() {
                          anonymousComplaint = values.isNotEmpty;
                        });
                      },
                    ),
                  ],
                ),
              ),
              
              // File Attachments Section
              Container(
                padding: EdgeInsets.all(spSm),
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
                        Icon(Icons.attach_file, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Attachments (Optional)",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Attach File",
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: _attachFile,
                        ),
                      ],
                    ),
                    if (attachedFiles.isNotEmpty) ...[
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: attachedFiles.asMap().entries.map((entry) {
                            return Row(
                              children: [
                                Icon(Icons.file_present, color: primaryColor, size: 16),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${entry.value}",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _removeFile(entry.key),
                                  child: Icon(Icons.close, color: dangerColor, size: 16),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ] else ...[
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor, style: BorderStyle.solid),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.cloud_upload, color: disabledBoldColor, size: 32),
                            SizedBox(height: spXs),
                            Text(
                              "No files attached",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              
              // Submit Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Submit Complaint",
                  icon: Icons.send,
                  onPressed: _submitComplaint,
                ),
              ),
              
              // Recent Complaints Section
              Container(
                padding: EdgeInsets.all(spSm),
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
                        Icon(Icons.history, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Recent Complaints",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      spacing: spSm,
                      children: recentComplaints.map((complaint) {
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border(
                              left: BorderSide(
                                width: 4,
                                color: _getStatusColor("${complaint["status"]}"),
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${complaint["subject"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getPriorityColor("${complaint["priority"]}"),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${complaint["priority"]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "ID: ${complaint["id"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(" • ", style: TextStyle(color: disabledBoldColor)),
                                  Text(
                                    "${complaint["type"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today, color: disabledBoldColor, size: 12),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${complaint["date"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor("${complaint["status"]}").withAlpha(50),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${complaint["status"]}",
                                      style: TextStyle(
                                        color: _getStatusColor("${complaint["status"]}"),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
