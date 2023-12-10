import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pose_detection_app/models/pose_one_model.dart';

Future<String> getAssetPath(String asset) async {
  final path = await getLocalPath(asset);
  await Directory(dirname(path)).create(recursive: true);
  final file = File(path);
  if (!await file.exists()) {
    final byteData = await rootBundle.load(asset);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }
  return file.path;
}

Future<String> getLocalPath(String path) async {
  return '${(await getApplicationSupportDirectory()).path}/$path';
}

double angleElbowShoulderHip(
    PoseLandmark elbowLandmark,
    PoseLandmark shoulderLandmark,
    PoseLandmark hipLandmark,
    ) {
  final radiansElbowShoulder = math.atan2(
    shoulderLandmark.y - hipLandmark.y,
    shoulderLandmark.x - hipLandmark.x,
  ) -
      math.atan2(
        elbowLandmark.y - shoulderLandmark.y,
        elbowLandmark.x - shoulderLandmark.x,
      );

  double degrees = radiansElbowShoulder * 180.0 / math.pi;
  degrees = degrees.abs(); // Angle should never be negative

  return degrees;
}

PoseState isNearly90DegreePose(
    double rightElbowShoulderHipAngle,
    double leftElbowShoulderHipAngle,
    PoseState current,
    ) {
  final threshold = 20.0; // Adjust this threshold as needed

  if (current == PoseState.neutral &&
      (rightElbowShoulderHipAngle > (90 - threshold) &&
          rightElbowShoulderHipAngle < (90 + threshold)) &&
      (leftElbowShoulderHipAngle > (90 - threshold) &&
          leftElbowShoulderHipAngle < (90 + threshold))) {
    return PoseState.correct; // Transition to 'correct' state for the desired pose
  } else if (current == PoseState.correct &&
      ((rightElbowShoulderHipAngle <= (90 - threshold) ||
          rightElbowShoulderHipAngle >= (90 + threshold)) ||
          (leftElbowShoulderHipAngle <= (90 - threshold) ||
              leftElbowShoulderHipAngle >= (90 + threshold)))) {
    return PoseState.neutral; // Return to 'neutral' if the pose alignment is lost
  }

  return current; // Return current state if conditions are not met
}
