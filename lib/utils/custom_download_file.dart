import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cr_file_saver/file_saver.dart';
import 'package:path_provider/path_provider.dart';

const _tempFileName = 'TempFile.pdf';

/// Save created file from temporary directory to downloads folder on Android
/// or to Documents on IOS with native dialog
void onSaveWithDialogPressed(String base64Image) async {
  // Decode the Base64 string to bytes
  final decodedBytes = base64Decode(base64Image);

  // Get a temporary directory to save the file
  final folder = await getTemporaryDirectory();
  final filePath =
      '${folder.path}/image.png'; // Specify the file format, e.g., PNG

  try {
    // Write the bytes to the file
    final file = File(filePath);
    await file.writeAsBytes(decodedBytes);  

    // Save the file with a dialog (using your existing method)
    final savedFile = await CRFileSaver.saveFileWithDialog(SaveFileDialogParams(
      sourceFilePath: filePath,
      destinationFileName: 'file_name.png', // Specify the desired file name
    ));

    log('Saved to $savedFile');
  } catch (error) {
    log('Error: $error');
  }
}

Future<bool> _checkIsTempFileExists() async {
  final folder = await getTemporaryDirectory();
  final filePath = '${folder.path}/$_tempFileName';
  final file = File(filePath);

  return file.exists();
}
