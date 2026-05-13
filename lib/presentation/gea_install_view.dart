import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaInstallView extends StatefulWidget {
  const GeaInstallView({super.key});

  @override
  State<GeaInstallView> createState() => _GeaInstallViewState();
}

class _GeaInstallViewState extends State<GeaInstallView> {
  bool isInstalling = false;
  double installProgress = 0.0;
  String currentStep = "";
  String selectedPath = "C:\\Games";
  bool createDesktopShortcut = true;
  bool createStartMenuShortcut = true;
  bool launchAfterInstall = true;

  List<Map<String, dynamic>> downloadedGames = [
    {
      "id": 1,
      "title": "Cyber Combat 2077",
      "size": "45.2 GB",
      "version": "1.3.2",
      "downloadedSize": "45.2 GB",
      "cover": "https://picsum.photos/400/600?random=1&keyword=game",
      "isDownloaded": true,
      "isInstalled": false,
      "installProgress": 0.0,
      "downloadPath": "C:\\Users\\Downloads\\CyberCombat2077.exe",
      "requiredSpace": 70.5,
      "installSteps": [
        "Extracting game files",
        "Installing DirectX components",
        "Installing Visual C++ Redistributables",
        "Configuring game settings",
        "Creating shortcuts",
        "Finalizing installation"
      ]
    },
    {
      "id": 2,
      "title": "Fantasy Realm Quest",
      "size": "28.7 GB",
      "version": "2.1.0",
      "downloadedSize": "28.7 GB",
      "cover": "https://picsum.photos/400/600?random=2&keyword=fantasy",
      "isDownloaded": true,
      "isInstalled": true,
      "installProgress": 100.0,
      "downloadPath": "C:\\Users\\Downloads\\FantasyRealm.exe",
      "requiredSpace": 35.0,
      "installSteps": [
        "Extracting game files",
        "Installing game engine",
        "Configuring graphics settings",
        "Creating shortcuts",
        "Finalizing installation"
      ]
    },
    {
      "id": 3,
      "title": "Racing Thunder",
      "size": "15.3 GB",
      "version": "1.8.5",
      "downloadedSize": "15.3 GB",
      "cover": "https://picsum.photos/400/600?random=3&keyword=racing",
      "isDownloaded": true,
      "isInstalled": false,
      "installProgress": 0.0,
      "downloadPath": "C:\\Users\\Downloads\\RacingThunder.exe",
      "requiredSpace": 20.0,
      "installSteps": [
        "Extracting game files",
        "Installing physics engine",
        "Configuring audio settings",
        "Creating shortcuts",
        "Finalizing installation"
      ]
    },
  ];

  List<Map<String, dynamic>> installQueue = [];

  void _startInstallation(Map<String, dynamic> game) {
    setState(() {
      game["isInstalled"] = false;
      game["installProgress"] = 0.0;
      installQueue.add(game);
      if (installQueue.length == 1) {
        _simulateInstallation(game);
      }
    });
    ss("Installation started for ${game["title"]}");
  }

  void _simulateInstallation(Map<String, dynamic> game) {
    setState(() {
      isInstalling = true;
      currentStep = (game["installSteps"] as List<String>)[0];
      installProgress = 0.0;
    });
    // Simulate installation progress
  }

  void _pauseInstallation(Map<String, dynamic> game) {
    setState(() {
      isInstalling = false;
    });
    si("Installation paused for ${game["title"]}");
  }

  void _resumeInstallation(Map<String, dynamic> game) {
    setState(() {
      isInstalling = true;
    });
    si("Installation resumed for ${game["title"]}");
  }

  void _cancelInstallation(Map<String, dynamic> game) {
    setState(() {
      game["installProgress"] = 0.0;
      installQueue.removeWhere((g) => g["id"] == game["id"]);
      isInstalling = installQueue.isNotEmpty;
    });
    sw("Installation cancelled for ${game["title"]}");
  }

  void _uninstallGame(Map<String, dynamic> game) async {
    bool isConfirmed = await confirm("Are you sure you want to uninstall ${game["title"]}?");
    if (isConfirmed) {
      setState(() {
        game["isInstalled"] = false;
        game["installProgress"] = 0.0;
      });
      ss("${game["title"]} has been uninstalled");
    }
  }

  void _selectInstallPath() async {
    // Simulate folder picker
    si("Install path selection is not implemented in this demo");
  }

  double _getAvailableSpace() {
    return 250.5; // GB
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Installation Manager"),
        actions: [
          IconButton(
            icon: Icon(Icons.folder),
            onPressed: _selectInstallPath,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Installation Settings
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
                    "Installation Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.folder,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Install Path",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              selectedPath,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Change",
                        size: bs.sm,
                        onPressed: _selectInstallPath,
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.storage,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Available Space: ${_getAvailableSpace().toStringAsFixed(1)} GB",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: createDesktopShortcut,
                            onChanged: (value) {
                              createDesktopShortcut = value ?? false;
                              setState(() {});
                            },
                          ),
                          Text(
                            "Create desktop shortcut",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: createStartMenuShortcut,
                            onChanged: (value) {
                              createStartMenuShortcut = value ?? false;
                              setState(() {});
                            },
                          ),
                          Text(
                            "Create Start Menu shortcut",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: launchAfterInstall,
                            onChanged: (value) {
                              launchAfterInstall = value ?? false;
                              setState(() {});
                            },
                          ),
                          Text(
                            "Launch game after installation",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Current Installation Progress
            if (isInstalling) ...[
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
                        Icon(
                          Icons.install_desktop,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Installing: ${installQueue.isNotEmpty ? installQueue[0]["title"] : ""}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        QButton(
                          icon: Icons.pause,
                          size: bs.sm,
                          onPressed: () {
                            if (installQueue.isNotEmpty) {
                              _pauseInstallation(installQueue[0]);
                            }
                          },
                        ),
                      ],
                    ),
                    
                    Text(
                      "Step: $currentStep",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    LinearProgressIndicator(
                      value: installProgress / 100,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${installProgress.toStringAsFixed(1)}% Complete",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "~5 minutes remaining",
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
            ],

            // Installation Queue
            if (installQueue.isNotEmpty) ...[
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
                      "Installation Queue (${installQueue.length})",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    ...installQueue.map((game) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Image.network(
                                "${game["cover"]}",
                                width: 40,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${game["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Size: ${game["size"]} • Requires: ${game["requiredSpace"]} GB",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            QButton(
                              icon: Icons.close,
                              size: bs.sm,
                              onPressed: () => _cancelInstallation(game),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],

            // Downloaded Games
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
                    "Downloaded Games",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  ...downloadedGames.map((game) {
                    final isInstalled = game["isInstalled"] as bool;
                    final isInQueue = installQueue.any((g) => g["id"] == game["id"]);
                    final requiredSpace = game["requiredSpace"] as double;
                    final hasEnoughSpace = _getAvailableSpace() >= requiredSpace;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  "${game["cover"]}",
                                  width: 60,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "${game["title"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Version: ${game["version"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "Size: ${game["size"]} • Requires: ${requiredSpace.toStringAsFixed(1)} GB",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    if (!hasEnoughSpace)
                                      Text(
                                        "⚠️ Insufficient storage space",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: dangerColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          Row(
                            children: [
                              if (isInstalled) ...[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "Installed",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                QButton(
                                  label: "Uninstall",
                                  size: bs.sm,
                                  onPressed: () => _uninstallGame(game),
                                ),
                              ] else if (isInQueue) ...[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: warningColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "In Queue",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                QButton(
                                  label: "Cancel",
                                  size: bs.sm,
                                  onPressed: () => _cancelInstallation(game),
                                ),
                              ] else ...[
                                Spacer(),
                                QButton(
                                  label: hasEnoughSpace ? "Install" : "Need Space",
                                  size: bs.sm,
                                  onPressed: hasEnoughSpace ? () => _startInstallation(game) : null,
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
