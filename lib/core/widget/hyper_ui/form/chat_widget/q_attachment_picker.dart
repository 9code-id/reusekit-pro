import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class QAttachmentPicker extends StatefulWidget {
  final String? label;
  final List<String> value;
  final String? hint;
  final String? helper;
  final String? Function(List<String>?)? validator;
  final Function(List<String> value) onChanged;
  final int maxAttachments;
  final List<String> allowedTypes;
  final bool enabled;

  const QAttachmentPicker({
    Key? key,
    this.label,
    required this.value,
    this.hint,
    this.helper,
    this.validator,
    required this.onChanged,
    this.maxAttachments = 10,
    this.allowedTypes = const ['image', 'document', 'video', 'audio'],
    this.enabled = true,
  }) : super(key: key);

  @override
  State<QAttachmentPicker> createState() => _QAttachmentPickerState();
}

class _QAttachmentPickerState extends State<QAttachmentPicker> {
  bool isPickerOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: EdgeInsets.only(bottom: spXs),
            child: Text(
              widget.label!,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
        
        // Attachment display area
        if (widget.value.isNotEmpty)
          Container(
            margin: EdgeInsets.only(bottom: spSm),
            child: Wrap(
              spacing: spSm,
              runSpacing: spSm,
              children: widget.value.map((attachment) => _buildAttachmentItem(attachment)).toList(),
            ),
          ),

        // Picker button
        GestureDetector(
          onTap: widget.enabled ? _showAttachmentPicker : null,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: widget.enabled ? Colors.white : Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: widget.enabled ? primaryColor.withAlpha(100) : disabledColor,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.attach_file,
                  color: widget.enabled ? primaryColor : disabledBoldColor,
                  size: 32,
                ),
                SizedBox(height: spSm),
                Text(
                  widget.hint ?? "Tap to attach files",
                  style: TextStyle(
                    color: widget.enabled ? primaryColor : disabledBoldColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (widget.value.length < widget.maxAttachments)
                  Text(
                    "${widget.value.length}/${widget.maxAttachments} files selected",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
        ),

        if (widget.helper != null)
          Padding(
            padding: EdgeInsets.only(top: spXs),
            child: Text(
              widget.helper!,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAttachmentItem(String attachment) {
    String fileName = attachment.split('/').last;
    String fileExtension = fileName.split('.').last.toLowerCase();
    IconData fileIcon = _getFileIcon(fileExtension);
    Color fileColor = _getFileColor(fileExtension);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledColor),
        boxShadow: [shadowSm],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: fileColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              fileIcon,
              color: fileColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: 120),
                child: Text(
                  fileName,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                fileExtension.toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () => _removeAttachment(attachment),
            child: Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: dangerColor,
                size: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getFileIcon(String extension) {
    switch (extension) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'bmp':
      case 'webp':
        return Icons.image;
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      case 'ppt':
      case 'pptx':
        return Icons.slideshow;
      case 'mp4':
      case 'avi':
      case 'mov':
      case 'wmv':
        return Icons.video_file;
      case 'mp3':
      case 'wav':
      case 'aac':
      case 'flac':
        return Icons.audio_file;
      case 'zip':
      case 'rar':
      case '7z':
        return Icons.archive;
      case 'txt':
        return Icons.text_snippet;
      default:
        return Icons.insert_drive_file;
    }
  }

  Color _getFileColor(String extension) {
    switch (extension) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'bmp':
      case 'webp':
        return successColor;
      case 'pdf':
        return dangerColor;
      case 'doc':
      case 'docx':
        return infoColor;
      case 'xls':
      case 'xlsx':
        return successColor;
      case 'ppt':
      case 'pptx':
        return warningColor;
      case 'mp4':
      case 'avi':
      case 'mov':
      case 'wmv':
        return primaryColor;
      case 'mp3':
      case 'wav':
      case 'aac':
      case 'flac':
        return warningColor;
      case 'zip':
      case 'rar':
      case '7z':
        return disabledBoldColor;
      case 'txt':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showAttachmentPicker() {
    if (widget.value.length >= widget.maxAttachments) {
      se("Maximum ${widget.maxAttachments} files allowed");
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusLg),
            topRight: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
            Text(
              "Select Attachment Type",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            if (widget.allowedTypes.contains('image'))
              _buildPickerOption(
                icon: Icons.image,
                title: "Photos & Images",
                subtitle: "JPG, PNG, GIF, WebP",
                color: successColor,
                onTap: () => _pickFiles('image'),
              ),
            
            if (widget.allowedTypes.contains('document'))
              _buildPickerOption(
                icon: Icons.description,
                title: "Documents",
                subtitle: "PDF, DOC, XLS, PPT, TXT",
                color: infoColor,
                onTap: () => _pickFiles('document'),
              ),
            
            if (widget.allowedTypes.contains('video'))
              _buildPickerOption(
                icon: Icons.video_file,
                title: "Videos",
                subtitle: "MP4, AVI, MOV, WMV",
                color: primaryColor,
                onTap: () => _pickFiles('video'),
              ),
            
            if (widget.allowedTypes.contains('audio'))
              _buildPickerOption(
                icon: Icons.audio_file,
                title: "Audio Files",
                subtitle: "MP3, WAV, AAC, FLAC",
                color: warningColor,
                onTap: () => _pickFiles('audio'),
              ),
            
            _buildPickerOption(
              icon: Icons.folder,
              title: "All Files",
              subtitle: "Any file type",
              color: disabledBoldColor,
              onTap: () => _pickFiles('all'),
            ),
            
            SizedBox(height: spSm),
          ],
        ),
      ),
    );
  }

  Widget _buildPickerOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: color.withAlpha(50)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: disabledBoldColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _pickFiles(String type) {
    back(); // Close bottom sheet
    
    // Simulate file picking - in real implementation, use file_picker package
    List<String> newFiles = [];
    
    switch (type) {
      case 'image':
        newFiles = [
          'https://picsum.photos/400/300?random=1',
          'https://picsum.photos/400/300?random=2',
        ];
        break;
      case 'document':
        newFiles = [
          '/storage/emulated/0/Documents/report.pdf',
          '/storage/emulated/0/Documents/presentation.pptx',
        ];
        break;
      case 'video':
        newFiles = [
          '/storage/emulated/0/Videos/sample_video.mp4',
        ];
        break;
      case 'audio':
        newFiles = [
          '/storage/emulated/0/Music/sample_audio.mp3',
        ];
        break;
      case 'all':
        newFiles = [
          '/storage/emulated/0/Downloads/file.zip',
        ];
        break;
    }
    
    List<String> updatedFiles = List.from(widget.value);
    
    for (String file in newFiles) {
      if (updatedFiles.length < widget.maxAttachments && !updatedFiles.contains(file)) {
        updatedFiles.add(file);
      }
    }
    
    widget.onChanged(updatedFiles);
    ss("${newFiles.length} file(s) attached successfully!");
  }

  void _removeAttachment(String attachment) {
    List<String> updatedFiles = List.from(widget.value);
    updatedFiles.remove(attachment);
    widget.onChanged(updatedFiles);
    ss("File removed successfully!");
  }
}