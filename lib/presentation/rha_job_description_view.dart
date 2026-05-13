import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaJobDescriptionView extends StatefulWidget {
  const RhaJobDescriptionView({super.key});

  @override
  State<RhaJobDescriptionView> createState() => _RhaJobDescriptionViewState();
}

class _RhaJobDescriptionViewState extends State<RhaJobDescriptionView> {
  final formKey = GlobalKey<FormState>();
  
  String jobTitle = "Senior Flutter Developer";
  String department = "Engineering";
  String reportingTo = "Engineering Manager";
  String jobSummary = "";
  String keyResponsibilities = "";
  String dailyTasks = "";
  String projectInvolvement = "";
  String teamCollaboration = "";
  String companyOverview = "";
  String workEnvironment = "";
  String growthOpportunities = "";
  
  bool useTemplate = false;
  String selectedTemplate = "Software Developer";
  
  List<Map<String, dynamic>> templateItems = [
    {"label": "Software Developer", "value": "Software Developer"},
    {"label": "Marketing Manager", "value": "Marketing Manager"},
    {"label": "Sales Representative", "value": "Sales Representative"},
    {"label": "HR Specialist", "value": "HR Specialist"},
    {"label": "Data Analyst", "value": "Data Analyst"},
    {"label": "Project Manager", "value": "Project Manager"},
  ];

  Map<String, Map<String, String>> jobTemplates = {
    "Software Developer": {
      "summary": "We are seeking a talented Software Developer to join our dynamic engineering team. You will be responsible for developing high-quality software solutions, collaborating with cross-functional teams, and contributing to innovative projects that impact millions of users.",
      "responsibilities": "• Design, develop, and maintain software applications\n• Write clean, efficient, and well-documented code\n• Participate in code reviews and technical discussions\n• Collaborate with product managers and designers\n• Debug and resolve software issues\n• Stay updated with latest technology trends",
      "dailyTasks": "• Write and review code for new features\n• Attend daily stand-up meetings\n• Test and debug applications\n• Collaborate with team members on technical solutions\n• Document code and development processes\n• Participate in sprint planning and retrospectives",
    },
    "Marketing Manager": {
      "summary": "Join our marketing team as a Marketing Manager to drive brand awareness, lead generation, and customer engagement. You will develop and execute comprehensive marketing strategies while managing campaigns across multiple channels.",
      "responsibilities": "• Develop and implement marketing strategies\n• Manage marketing campaigns and budgets\n• Analyze market trends and competitor activities\n• Coordinate with sales and product teams\n• Oversee content creation and brand messaging\n• Track and report on marketing performance metrics",
      "dailyTasks": "• Review campaign performance and analytics\n• Coordinate with creative teams on content\n• Attend marketing and cross-team meetings\n• Plan and schedule marketing activities\n• Manage relationships with external vendors\n• Update marketing materials and documentation",
    },
    "Sales Representative": {
      "summary": "We are looking for a results-driven Sales Representative to expand our customer base and drive revenue growth. You will be responsible for building relationships with prospects, understanding their needs, and presenting our solutions effectively.",
      "responsibilities": "• Generate new leads and build sales pipeline\n• Conduct product demonstrations and presentations\n• Negotiate contracts and close deals\n• Maintain customer relationships and account management\n• Collaborate with marketing and product teams\n• Meet and exceed sales targets and quotas",
      "dailyTasks": "• Make sales calls and follow up with prospects\n• Update CRM with customer interactions\n• Prepare proposals and quotes\n• Attend sales meetings and training sessions\n• Research potential customers and market opportunities\n• Coordinate with support teams for customer needs",
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Description"),
        actions: [
          IconButton(
            icon: Icon(Icons.preview),
            onPressed: () {
              _showPreview();
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                ss("Job description saved successfully");
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            children: [
              // Template Selection
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.description,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Use Job Description Template",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Enable template usage",
                          "value": true,
                          "checked": useTemplate,
                        }
                      ],
                      value: [
                        if (useTemplate)
                          {
                            "label": "Enable template usage",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        useTemplate = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    if (useTemplate) ...[
                      QDropdownField(
                        label: "Select Template",
                        items: templateItems,
                        value: selectedTemplate,
                        onChanged: (value, label) {
                          selectedTemplate = value;
                          _applyTemplate(value);
                          setState(() {});
                        },
                      ),
                      QButton(
                        label: "Apply Template",
                        size: bs.sm,
                        onPressed: () {
                          _applyTemplate(selectedTemplate);
                        },
                      ),
                    ],
                  ],
                ),
              ),

              // Basic Information Section
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
                    Text(
                      "Position Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Job Title",
                      value: jobTitle,
                      validator: Validator.required,
                      onChanged: (value) {
                        jobTitle = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Department",
                            value: department,
                            validator: Validator.required,
                            onChanged: (value) {
                              department = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Reporting To",
                            value: reportingTo,
                            validator: Validator.required,
                            onChanged: (value) {
                              reportingTo = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Job Summary Section
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
                    Text(
                      "Job Summary",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QMemoField(
                      label: "Job Summary",
                      value: jobSummary,
                      hint: "Provide a compelling overview of the position that will attract qualified candidates",
                      validator: Validator.required,
                      onChanged: (value) {
                        jobSummary = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Responsibilities Section
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
                    Text(
                      "Key Responsibilities",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QMemoField(
                      label: "Key Responsibilities",
                      value: keyResponsibilities,
                      hint: "List the main responsibilities and duties of this position",
                      validator: Validator.required,
                      onChanged: (value) {
                        keyResponsibilities = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Daily Tasks",
                      value: dailyTasks,
                      hint: "Describe typical daily activities and tasks",
                      onChanged: (value) {
                        dailyTasks = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Project Involvement",
                      value: projectInvolvement,
                      hint: "Describe involvement in projects and initiatives",
                      onChanged: (value) {
                        projectInvolvement = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Team and Collaboration Section
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
                    Text(
                      "Team & Collaboration",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QMemoField(
                      label: "Team Collaboration",
                      value: teamCollaboration,
                      hint: "Describe how this role works with other teams and departments",
                      onChanged: (value) {
                        teamCollaboration = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Company Information Section
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
                    Text(
                      "Company Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QMemoField(
                      label: "Company Overview",
                      value: companyOverview,
                      hint: "Brief description of the company, mission, and values",
                      onChanged: (value) {
                        companyOverview = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Work Environment",
                      value: workEnvironment,
                      hint: "Describe the work culture, office environment, and team dynamics",
                      onChanged: (value) {
                        workEnvironment = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Growth Opportunities",
                      value: growthOpportunities,
                      hint: "Career development and advancement opportunities",
                      onChanged: (value) {
                        growthOpportunities = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Writing Tips Section
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: warningColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb,
                          color: warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Writing Tips",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "• Use action verbs to describe responsibilities\n• Be specific about skills and qualifications\n• Include information about company culture\n• Mention growth opportunities and benefits\n• Keep the tone professional yet engaging\n• Use bullet points for easy readability",
                      style: TextStyle(
                        color: warningColor,
                        fontSize: 12,
                      ),
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
                      label: "Save Draft",
                      size: bs.md,
                      onPressed: () {
                        ss("Description saved as draft");
                      },
                    ),
                  ),
                  Expanded(
                    child: QButton(
                      label: "Save & Continue",
                      size: bs.md,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ss("Job description saved successfully");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _applyTemplate(String templateKey) {
    if (jobTemplates.containsKey(templateKey)) {
      final template = jobTemplates[templateKey]!;
      jobSummary = template["summary"] ?? "";
      keyResponsibilities = template["responsibilities"] ?? "";
      dailyTasks = template["dailyTasks"] ?? "";
      setState(() {});
      ss("Template applied successfully");
    }
  }

  void _showPreview() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Job Description Preview"),
        content: Container(
          width: double.maxFinite,
          height: 400,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  jobTitle,
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "$department • Reports to: $reportingTo",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
                if (jobSummary.isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Text(
                    "Job Summary",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(jobSummary),
                ],
                if (keyResponsibilities.isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Text(
                    "Key Responsibilities",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(keyResponsibilities),
                ],
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
