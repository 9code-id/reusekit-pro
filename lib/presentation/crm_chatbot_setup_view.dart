import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmChatbotSetupView extends StatefulWidget {
  const CrmChatbotSetupView({super.key});

  @override
  State<CrmChatbotSetupView> createState() => _CrmChatbotSetupViewState();
}

class _CrmChatbotSetupViewState extends State<CrmChatbotSetupView> {
  int currentTab = 0;
  
  // Bot Configuration
  String botName = "Customer Support Bot";
  String welcomeMessage = "Hello! How can I help you today?";
  String fallbackMessage = "I'm sorry, I didn't understand. Let me connect you with a human agent.";
  bool enableBot = true;
  bool enableLiveHandoff = true;
  bool enableBusinessHours = true;
  String businessHoursStart = "09:00";
  String businessHoursEnd = "17:00";
  
  // Knowledge Base
  String selectedCategory = "General";
  String questionText = "";
  String answerText = "";
  String intentName = "";
  String trainingPhrase = "";
  
  // Analytics filters
  String selectedPeriod = "7days";
  String selectedMetric = "conversations";
  
  List<Map<String, dynamic>> botIntents = [
    {
      "id": 1,
      "name": "Greeting",
      "examples": ["hello", "hi", "good morning", "hey"],
      "response": "Hello! How can I assist you today?",
      "confidence": 0.95,
      "status": "active",
    },
    {
      "id": 2,
      "name": "Product Info",
      "examples": ["tell me about", "product details", "features"],
      "response": "I'd be happy to help you learn about our products. What specifically would you like to know?",
      "confidence": 0.88,
      "status": "active",
    },
    {
      "id": 3,
      "name": "Pricing",
      "examples": ["how much", "price", "cost", "pricing"],
      "response": "Here are our current pricing options. Would you like me to connect you with sales for a custom quote?",
      "confidence": 0.92,
      "status": "active",
    },
    {
      "id": 4,
      "name": "Technical Support",
      "examples": ["not working", "error", "problem", "issue"],
      "response": "I understand you're experiencing a technical issue. Let me help you troubleshoot or connect you with our technical team.",
      "confidence": 0.85,
      "status": "training",
    },
  ];

  List<Map<String, dynamic>> conversationFlows = [
    {
      "id": 1,
      "name": "Customer Onboarding",
      "steps": 5,
      "completion_rate": 78,
      "avg_time": "3.2 min",
      "status": "active",
    },
    {
      "id": 2,
      "name": "Product Demo Request",
      "steps": 3,
      "completion_rate": 85,
      "avg_time": "1.8 min",
      "status": "active",
    },
    {
      "id": 3,
      "name": "Technical Troubleshooting",
      "steps": 7,
      "completion_rate": 65,
      "avg_time": "5.1 min",
      "status": "draft",
    },
    {
      "id": 4,
      "name": "Refund Request",
      "steps": 4,
      "completion_rate": 72,
      "avg_time": "2.9 min",
      "status": "active",
    },
  ];

  List<Map<String, dynamic>> performanceMetrics = [
    {"label": "Total Conversations", "value": "2,485", "change": "+12%", "trend": "up"},
    {"label": "Bot Resolution Rate", "value": "67%", "change": "+5%", "trend": "up"},
    {"label": "Avg Response Time", "value": "0.8s", "change": "-0.2s", "trend": "down"},
    {"label": "Human Handoff Rate", "value": "33%", "change": "-3%", "trend": "down"},
    {"label": "User Satisfaction", "value": "4.2/5", "change": "+0.3", "trend": "up"},
    {"label": "Training Accuracy", "value": "89%", "change": "+2%", "trend": "up"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Chatbot Setup",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Configuration", icon: Icon(Icons.settings)),
        Tab(text: "Intents", icon: Icon(Icons.psychology)),
        Tab(text: "Flows", icon: Icon(Icons.account_tree)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildConfigurationTab(),
        _buildIntentsTab(),
        _buildFlowsTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildConfigurationTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildBotSettingsCard(),
          _buildMessageTemplatesCard(),
          _buildBusinessHoursCard(),
          _buildIntegrationsCard(),
        ],
      ),
    );
  }

  Widget _buildBotSettingsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Bot Configuration",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          QTextField(
            label: "Bot Name",
            value: botName,
            onChanged: (value) {
              botName = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Enable Chatbot",
                      "value": true,
                      "checked": enableBot,
                    }
                  ],
                  value: [
                    if (enableBot)
                      {
                        "label": "Enable Chatbot",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    enableBot = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Enable Live Handoff",
                      "value": true,
                      "checked": enableLiveHandoff,
                    }
                  ],
                  value: [
                    if (enableLiveHandoff)
                      {
                        "label": "Enable Live Handoff",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    enableLiveHandoff = values.isNotEmpty;
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

  Widget _buildMessageTemplatesCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Message Templates",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          QMemoField(
            label: "Welcome Message",
            value: welcomeMessage,
            hint: "Message shown when chat starts",
            onChanged: (value) {
              welcomeMessage = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Fallback Message",
            value: fallbackMessage,
            hint: "Message when bot doesn't understand",
            onChanged: (value) {
              fallbackMessage = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessHoursCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Business Hours",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Enable Business Hours",
                      "value": true,
                      "checked": enableBusinessHours,
                    }
                  ],
                  value: [
                    if (enableBusinessHours)
                      {
                        "label": "Enable Business Hours",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    enableBusinessHours = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          if (enableBusinessHours) ...[
            Row(
              children: [
                Expanded(
                  child: QTimePicker(
                    label: "Start Time",
                    value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 ${businessHoursStart}:00")),
                    onChanged: (value) {
                      businessHoursStart = value!.format(context);
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QTimePicker(
                    label: "End Time",
                    value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 ${businessHoursEnd}:00")),
                    onChanged: (value) {
                      businessHoursEnd = value!.format(context);
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildIntegrationsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Integrations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.api, color: primaryColor),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "API Endpoint",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Connected",
                              style: TextStyle(
                                color: successColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Configure",
                        size: bs.sm,
                        onPressed: () {},
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

  Widget _buildIntentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildIntentCreationCard(),
          _buildIntentsListCard(),
        ],
      ),
    );
  }

  Widget _buildIntentCreationCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Create Intent",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          QTextField(
            label: "Intent Name",
            value: intentName,
            hint: "e.g., Product Information",
            onChanged: (value) {
              intentName = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Training Phrase",
            value: trainingPhrase,
            hint: "e.g., tell me about your products",
            onChanged: (value) {
              trainingPhrase = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Bot Response",
            value: answerText,
            hint: "How should the bot respond?",
            onChanged: (value) {
              answerText = value;
              setState(() {});
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add Intent",
              size: bs.md,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntentsListCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Expanded(
                child: Text(
                  "Trained Intents",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              QButton(
                label: "Train Model",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...botIntents.map((intent) => _buildIntentItem(intent)),
        ],
      ),
    );
  }

  Widget _buildIntentItem(Map<String, dynamic> intent) {
    Color statusColor = intent["status"] == "active" 
        ? successColor 
        : intent["status"] == "training" 
        ? warningColor 
        : disabledColor;

    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${intent["name"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${intent["status"]}".toUpperCase(),
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "${((intent["confidence"] as double) * 100).toInt()}%",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Text(
            "Examples: ${(intent["examples"] as List).join(", ")}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
          Text(
            "${intent["response"]}",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          Row(
            children: [
              Spacer(),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.delete,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFlowsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildFlowStatsCard(),
          _buildFlowsListCard(),
        ],
      ),
    );
  }

  Widget _buildFlowStatsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Flow Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildFlowStatItem("Active Flows", "3", successColor),
              ),
              Expanded(
                child: _buildFlowStatItem("Avg Completion", "75%", infoColor),
              ),
              Expanded(
                child: _buildFlowStatItem("Avg Duration", "3.0 min", warningColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFlowStatItem(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlowsListCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Expanded(
                child: Text(
                  "Conversation Flows",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...conversationFlows.map((flow) => _buildFlowItem(flow)),
        ],
      ),
    );
  }

  Widget _buildFlowItem(Map<String, dynamic> flow) {
    Color statusColor = flow["status"] == "active" 
        ? successColor 
        : flow["status"] == "draft" 
        ? warningColor 
        : disabledColor;

    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${flow["name"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${flow["status"]}".toUpperCase(),
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "${flow["steps"]} steps",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "${flow["completion_rate"]}% completion",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "${flow["avg_time"]} avg",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Spacer(),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.delete,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAnalyticsFiltersCard(),
          _buildPerformanceMetricsCard(),
          _buildConversationInsightsCard(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsFiltersCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Analytics Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Time Period",
                  value: selectedPeriod,
                  items: [
                    {"label": "Last 7 Days", "value": "7days"},
                    {"label": "Last 30 Days", "value": "30days"},
                    {"label": "Last 3 Months", "value": "3months"},
                    {"label": "Last Year", "value": "1year"},
                  ],
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Metric Type",
                  value: selectedMetric,
                  items: [
                    {"label": "Conversations", "value": "conversations"},
                    {"label": "Resolution Rate", "value": "resolution"},
                    {"label": "Response Time", "value": "response_time"},
                    {"label": "User Satisfaction", "value": "satisfaction"},
                  ],
                  onChanged: (value, label) {
                    selectedMetric = value;
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

  Widget _buildPerformanceMetricsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Performance Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(
            spacing: spXs,
            children: performanceMetrics.map((metric) {
              Color trendColor = metric["trend"] == "up" 
                  ? successColor 
                  : metric["trend"] == "down" 
                  ? dangerColor 
                  : disabledBoldColor;
              IconData trendIcon = metric["trend"] == "up" 
                  ? Icons.trending_up 
                  : metric["trend"] == "down" 
                  ? Icons.trending_down 
                  : Icons.trending_flat;

              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "${metric["label"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${metric["value"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            trendIcon,
                            color: trendColor,
                            size: 16,
                          ),
                          SizedBox(width: 2),
                          Text(
                            "${metric["change"]}",
                            style: TextStyle(
                              color: trendColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildConversationInsightsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Conversation Insights",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Top Unresolved Queries",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                  ),
                ),
                Text(
                  "• Account password reset procedures",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "• Billing cycle and payment processing",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "• Product compatibility questions",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Export Report",
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
