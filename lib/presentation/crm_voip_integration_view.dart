import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmVoipIntegrationView extends StatefulWidget {
  const CrmVoipIntegrationView({super.key});

  @override
  State<CrmVoipIntegrationView> createState() => _CrmVoipIntegrationViewState();
}

class _CrmVoipIntegrationViewState extends State<CrmVoipIntegrationView> {
  bool isConnected = true;
  bool isOnCall = false;
  bool isMuted = false;
  bool isHold = false;
  String callDuration = "00:00";
  String selectedProvider = "twilio";
  String currentNumber = "+1 234 567 8900";

  List<Map<String, dynamic>> voipProviders = [
    {"label": "Twilio", "value": "twilio"},
    {"label": "RingCentral", "value": "ringcentral"},
    {"label": "Vonage", "value": "vonage"},
    {"label": "8x8", "value": "8x8"},
  ];

  List<Map<String, dynamic>> activeConnections = [
    {
      "id": "1",
      "provider": "Twilio",
      "status": "connected",
      "region": "US East",
      "quality": "excellent",
      "latency": "12ms",
      "uptime": "99.9%"
    },
    {
      "id": "2",
      "provider": "RingCentral",
      "status": "connected",
      "region": "US West",
      "quality": "good",
      "latency": "18ms",
      "uptime": "99.8%"
    }
  ];

  List<Map<String, dynamic>> callQueue = [
    {
      "id": "1",
      "customerName": "John Smith",
      "customerPhone": "+1 234 567 8901",
      "waitTime": "2:15",
      "priority": "high",
      "reason": "Technical Support"
    },
    {
      "id": "2",
      "customerName": "Emily Davis",
      "customerPhone": "+1 234 567 8902",
      "waitTime": "1:42",
      "priority": "medium",
      "reason": "Billing Inquiry"
    },
    {
      "id": "3",
      "customerName": "Robert Brown",
      "customerPhone": "+1 234 567 8903",
      "waitTime": "0:58",
      "priority": "low",
      "reason": "General Question"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("VoIP Integration"),
        actions: [
          QButton(
            icon: Icons.settings_phone,
            size: bs.sm,
            onPressed: () {
              // VoIP settings
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              // Refresh connections
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildConnectionStatus(),
            if (isOnCall) _buildActiveCallCard(),
            _buildProviderSelection(),
            _buildCallQueue(),
            _buildProviderConnections(),
            _buildCallStatistics(),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectionStatus() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: isConnected ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: isConnected ? successColor.withAlpha(50) : dangerColor.withAlpha(50),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: isConnected ? successColor : dangerColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isConnected ? "VoIP Connected" : "VoIP Disconnected",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: isConnected ? successColor : dangerColor,
                  ),
                ),
                Text(
                  "Current Provider: ${selectedProvider.toUpperCase()}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: isConnected ? "Disconnect" : "Connect",
            size: bs.sm,
            color: isConnected ? dangerColor : successColor,
            onPressed: () {
              isConnected = !isConnected;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActiveCallCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  color: primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "John Smith",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "+1 234 567 8901",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                callDuration,
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
                child: QButton(
                  label: isMuted ? "Unmute" : "Mute",
                  size: bs.sm,
                  icon: isMuted ? Icons.mic_off : Icons.mic,
                  color: isMuted ? dangerColor : primaryColor,
                  onPressed: () {
                    isMuted = !isMuted;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: isHold ? "Resume" : "Hold",
                  size: bs.sm,
                  icon: isHold ? Icons.play_arrow : Icons.pause,
                  color: isHold ? warningColor : primaryColor,
                  onPressed: () {
                    isHold = !isHold;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "End Call",
                  size: bs.sm,
                  icon: Icons.call_end,
                  color: dangerColor,
                  onPressed: () {
                    isOnCall = false;
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

  Widget _buildProviderSelection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "VoIP Provider",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Select Provider",
            items: voipProviders,
            value: selectedProvider,
            onChanged: (value, label) {
              selectedProvider = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Phone Number",
                  value: currentNumber,
                  onChanged: (value) {
                    currentNumber = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Test Call",
                size: bs.sm,
                icon: Icons.phone,
                onPressed: () {
                  isOnCall = true;
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCallQueue() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Text(
                  "Call Queue",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${callQueue.length} waiting",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: callQueue.length,
            separatorBuilder: (context, index) => Divider(height: 1),
            itemBuilder: (context, index) {
              final call = callQueue[index];
              return _buildQueueItem(call);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQueueItem(Map<String, dynamic> call) {
    Color priorityColor = call["priority"] == "high" 
        ? dangerColor 
        : call["priority"] == "medium" 
        ? warningColor 
        : successColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 40,
            decoration: BoxDecoration(
              color: priorityColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${call["customerName"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${call["customerPhone"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Reason: ${call["reason"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Wait: ${call["waitTime"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: priorityColor,
                ),
              ),
              SizedBox(height: spXs),
              QButton(
                label: "Answer",
                size: bs.sm,
                icon: Icons.phone,
                onPressed: () {
                  isOnCall = true;
                  callQueue.removeWhere((c) => c["id"] == call["id"]);
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProviderConnections() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Active Connections",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: activeConnections.length,
            separatorBuilder: (context, index) => Divider(height: 1),
            itemBuilder: (context, index) {
              final connection = activeConnections[index];
              return _buildConnectionItem(connection);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionItem(Map<String, dynamic> connection) {
    Color qualityColor = connection["quality"] == "excellent" 
        ? successColor 
        : connection["quality"] == "good" 
        ? infoColor 
        : warningColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: qualityColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.cloud,
              color: qualityColor,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${connection["provider"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${connection["region"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${connection["latency"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: qualityColor,
                ),
              ),
              Text(
                "Uptime: ${connection["uptime"]}",
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
  }

  Widget _buildCallStatistics() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.call_made,
                  color: successColor,
                  size: 32,
                ),
                SizedBox(height: spSm),
                Text(
                  "245",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Outbound Calls",
                  textAlign: TextAlign.center,
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
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.call_received,
                  color: infoColor,
                  size: 32,
                ),
                SizedBox(height: spSm),
                Text(
                  "312",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Inbound Calls",
                  textAlign: TextAlign.center,
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
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.call_missed,
                  color: dangerColor,
                  size: 32,
                ),
                SizedBox(height: spSm),
                Text(
                  "18",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
                Text(
                  "Missed Calls",
                  textAlign: TextAlign.center,
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
    );
  }
}
