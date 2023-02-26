import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/videos/view_models/upload_video_vm.dart';

class VideoMetaScreen extends ConsumerStatefulWidget {
  final XFile video;

  const VideoMetaScreen({
    super.key,
    required this.video,
  });

  @override
  VideoMetaScreenState createState() => VideoMetaScreenState();
}

class VideoMetaScreenState extends ConsumerState<VideoMetaScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  String _title = "";
  String _desc = "";

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() {
      setState(() {
        _title = _titleController.text;
      });
    });
    _descController.addListener(() {
      setState(() {
        _desc = _descController.text;
      });
    });
  }

  String? _titleValid() {
    if (_title == "") {
      return "Title field required.";
    }
    return null;
  }

  String? _descValid() {
    if (_desc == "") {
      return "Description field required.";
    }
    return null;
  }

  _onUploadPressed() {
    if (_titleValid() != null || _descValid() != null) return;
    ref.read(uploadVideoProvider.notifier).uploadVideo(
          File(widget.video.path),
          _title,
          _desc,
          context,
        );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload video"),
        actions: [
          ref.watch(uploadVideoProvider).isLoading
              ? const CircularProgressIndicator.adaptive()
              : IconButton(
                  onPressed: ref.watch(uploadVideoProvider).isLoading
                      ? null
                      : _onUploadPressed,
                  icon: const FaIcon(FontAwesomeIcons.upload),
                ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Text(
                    "Title: ",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: _titleController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      errorText: _titleValid(),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade700,
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade700,
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Gaps.v16,
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Text(
                    "Description: ",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: _descController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      errorText: _descValid(),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade700,
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade700,
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
