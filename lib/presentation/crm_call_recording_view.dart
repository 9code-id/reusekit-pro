import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmCallRecordingView extends StatefulWidget {
  const CrmCallRecordingView({super.key});

  @override
  State<CrmCallRecordingView> createState() => _CrmCallRecordingViewState();
}

class _CrmCallRecordingViewState extends State<CrmCallRecordingView> {
  bool isRecording = false;
  bool isPlaying = false;
  double recordingDuration = 0;
  String selectedCallId = "";
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedDate = "";

  List<Map<String, dynamic>> recordings = [
    {
      "id": "1",
      "customerName": "John Smith",
      "customerPhone": "+1 234 567 8901",
      "duration": "5:42",
      "timestamp": "2024-06-19 09:15:00",
      "status": "completed",
      "agent": "Sarah Johnson",
      "quality": "excellent",
      "tags": ["sales", "inquiry"],
      "size": "2.3 MB",
      "transcription": "Available"
    },
    {
      "id": "2",
      "customerName": "Emily Davis",
      "customerPhone": "+1 234 567 8902",
      "duration": "3:28",
      "timestamp": "2024-06-19 08:45:00",
      "status": "completed",
      "agent": "Mike Wilson",
      "quality": "good",
      "tags": ["support", "technical"],
      "size": "1.8 MB",
      "transcription": "Processing"
    },
    {
      "id": "3",
      "customerName": "Robert Brown",
      "customerPhone": "+1 234 567 8903",
      "duration": "7:15",
      "timestamp": "2024-06-19 07:30:00",
      "status": "completed",
      "agent": "Lisa Chen",
      "quality": "fair",
      "tags": ["complaint", "resolution"],
      "size": "3.7 MB",
      "transcription": "Available"
    },
    {
      "id": "4",
      "customerName": "Maria Garcia",
      "customerPhone": "+1 234 567 8904",
      "duration": "2:10",
      "timestamp": "2024-06-19 06:20:00",
      "status": "in_progress",
      "agent": "David Park",
      "quality": "poor",
      "tags": ["sales", "follow_up"],
      "size": "1.1 MB",
      "transcription": "Pending"
    }
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Completed", "value": "completed"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Failed", "value": "failed"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Call Recording"),
        actions: [
          QButton(
            icon: Icons.upload_file,
            size: bs.sm,
            onPressed: () {
              // Upload recording
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {
              // Recording settings
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
            _buildActiveRecordingCard(),
            _buildFilterSection(),
            _buildRecordingStats(),
            _buildRecordingsList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          isRecording = !isRecording;
          setState(() {});
        },
        backgroundColor: isRecording ? dangerColor : primaryColor,
        child: Icon(
          isRecording ? Icons.stop : Icons.mic,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildActiveRecordingCard() {
    if (!isRecording) return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: dangerColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: dangerColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Recording in Progress",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
              Spacer(),
              Text(
                "02:45",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "Customer: John Doe",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Agent: Sarah Johnson",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Pause",
                  size: bs.sm,
                  icon: Icons.pause,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Stop",
                  size: bs.sm,
                  icon: Icons.stop,
                  color: dangerColor,
                  onPressed: () {
                    isRecording = false;
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

  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search recordings",
                  value: searchQuery,
                  hint: "Customer name, phone, or agent",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
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
                child: QDatePicker(
                  label: "Date",
                  value: selectedDate.isNotEmpty ? DateTime.parse(selectedDate) : DateTime.now(),
                  onChanged: (value) {
                    selectedDate = value.toString();
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

  Widget _buildRecordingStats() {
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
                  Icons.record_voice_over,
                  color: primaryColor,
                  size: 32,
                ),
                SizedBox(height: spSm),
                Text(
                  "156",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Recordings",
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
                  Icons.access_time,
                  color: successColor,
                  size: 32,
                ),
                SizedBox(height: spSm),
                Text(
                  "487 hrs",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Total Duration",
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
                  Icons.storage,
                  color: warningColor,
                  size: 32,
                ),
                SizedBox(height: spSm),
                Text(
                  "2.4 GB",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Storage Used",
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

  Widget _buildRecordingsList() {
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
              "Recent Recordings",
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
            itemCount: recordings.length,
            separatorBuilder: (context, index) => Divider(height: 1),
            itemBuilder: (context, index) {
              final recording = recordings[index];
              return _buildRecordingItem(recording);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingItem(Map<String, dynamic> recording) {
    Color statusColor = recording["status"] == "completed" 
        ? successColor 
        : recording["status"] == "in_progress" 
        ? warningColor 
        : dangerColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.record_voice_over,
                  color: primaryColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${recording["customerName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${recording["customerPhone"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${recording["status"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${recording["duration"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${recording["agent"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "${recording["size"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Wrap(
                spacing: spXs,
                children: (recording["tags"] as List).map((tag) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "$tag",
                      style: TextStyle(
                        fontSize: 10,
                        color: infoColor,
                      ),
                    ),
                  );
                }).toList(),
              ),
              Spacer(),
              Text(
                "Quality: ${recording["quality"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Play",
                  size: bs.sm,
                  icon: Icons.play_arrow,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.share,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.delete,
                size: bs.sm,
                color: dangerColor,
                onPressed: () async {
                  bool isConfirmed = await confirm("Delete this recording?");
                  if (isConfirmed) {
                    recordings.removeWhere((r) => r["id"] == recording["id"]);
                    setState(() {});
                    ss("Recording deleted successfully");
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
