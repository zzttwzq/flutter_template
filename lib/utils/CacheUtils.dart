import 'dart:io';
import 'package:app/utils/upload_alioss_util.dart';
import 'package:path_provider/path_provider.dart';

class CacheUtils {
  /// 加载缓存
  static Future<String> loadCache() async {
    Directory tempDir = await getTemporaryDirectory();
    double value = await _getTotalSizeOfFilesInDir(tempDir);

    tempDir.list(followLinks: false, recursive: true).listen((file) {
      //打印每个缓存文件的路径
      // print(file.path);
    });
    // print('临时目录大小: ' + value.toString());
    return getSizeText(value); // _cacheSizeStr用来存储大小的值
  }

  /// 清除缓存
  static clearCache() async {
    Directory tempDir = await getTemporaryDirectory();

    //删除缓存目录
    await delDir(tempDir);
  }

  ///2020.06.23更改：不需要递归删除，直接删除子目录和文件即可
  static Future<void> delDir(FileSystemEntity file) async {

    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await delDir(child);
        await child.delete();
      }
    }
  }

  static Future<double> _getTotalSizeOfFilesInDir(
      final FileSystemEntity file) async {
    if (file is File) {
      // print(file);
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      double total = 0;
      for (final FileSystemEntity child in children)
        total += await _getTotalSizeOfFilesInDir(child);
      return total;
    }
    return 0;
  }

  static String getSizeText(double value) {
    List<String> unitArr = []
      ..add('B')
      ..add('K')
      ..add('M')
      ..add('G');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }
}
