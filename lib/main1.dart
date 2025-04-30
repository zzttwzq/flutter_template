// import 'package:app/views/app.dart';
// import 'package:flutter/material.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   FlutterError.onError = (FlutterErrorDetails details) async {
//     debugPrint('>>> ${details.toString()}');
//   };

//   runApp(App());
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '视频水印工具',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: VideoWatermarkPage(),
    );
  }
}

class VideoWatermarkPage extends StatefulWidget {
  @override
  _VideoWatermarkPageState createState() => _VideoWatermarkPageState();
}

class _VideoWatermarkPageState extends State<VideoWatermarkPage> {
  File? _selectedVideo;
  bool _isProcessing = false;
  final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();

  // 选择本地视频文件
  Future<void> _pickVideo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedVideo = File(result.files.single.path!);
      });
    }
  }

  // 添加水印并保存
  Future<void> _addWatermark() async {
    if (_selectedVideo == null) return;

    // 请求存储权限
    if (!await _requestPermissions()) return;

    setState(() => _isProcessing = true);

    try {
      // 获取输出路径
      final appDir = await getApplicationDocumentsDirectory();
      final outputPath = '${appDir.path}/watermarked_${DateTime.now().millisecondsSinceEpoch}.mp4';

      // FFmpeg 水印命令
      final command = '''
      -i "${_selectedVideo!.path}" 
      -vf "drawtext=text='My Watermark':fontcolor=white:fontsize=24:box=1:boxcolor=black@0.5:x=10:y=10" 
      -c:a copy 
      "$outputPath"
      ''';

      // 执行FFmpeg命令
      final rc = await _flutterFFmpeg.execute(command);
      
      if (rc == 0) {
        _showResult('保存成功: $outputPath');
      } else {
        _showResult('处理失败，错误码: $rc');
      }
    } catch (e) {
      _showResult('发生错误: $e');
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  // 权限请求
  Future<bool> _requestPermissions() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  // 显示处理结果
  void _showResult(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('视频水印工具')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_selectedVideo != null)
                Text('已选择文件: ${_selectedVideo!.path.split('/').last}'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isProcessing ? null : _pickVideo,
                child: Text('选择视频文件'),
              ),
              SizedBox(height: 20),
              if (_isProcessing)
                CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _selectedVideo != null ? _addWatermark : null,
                  child: Text('添加水印并保存'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}