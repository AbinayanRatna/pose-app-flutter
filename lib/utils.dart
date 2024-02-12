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

double angleElbowShoulderHipLeft(
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
  degrees +=180;
  if(degrees<0){
    degrees+=360;
  }
  //degrees = degrees.abs(); // Angle should never be negative

  return degrees;
}

double angleElbowShoulderHipRight(
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
  degrees +=180;
  if(degrees<0){
    degrees+=360;
  }
  //degrees = degrees.abs(); // Angle should never be negative
  degrees =360-degrees;
  return degrees;
}

double angleShoulderHipKneeLeft(
    PoseLandmark shoulderLandmark,
    PoseLandmark hipLandmark,
    PoseLandmark kneeLandMark,
    ) {
  final radiansShoulderHip = math.atan2(
    hipLandmark.y - kneeLandMark.y,
    hipLandmark.x - kneeLandMark.x,
  ) -
      math.atan2(
        shoulderLandmark.y - hipLandmark.y,
        shoulderLandmark.x - hipLandmark.x,
      );

  double degrees = radiansShoulderHip * 180.0 / math.pi;
  degrees +=180;
  if(degrees<0){
    degrees+=360;
  }

  return degrees;
}

double angleShoulderHipKneeRight(
    PoseLandmark shoulderLandmark,
    PoseLandmark hipLandmark,
    PoseLandmark kneeLandMark,
    ) {
  final radiansShoulderHip = math.atan2(
    hipLandmark.y - kneeLandMark.y,
    hipLandmark.x - kneeLandMark.x,
  ) -
      math.atan2(
        shoulderLandmark.y - hipLandmark.y,
        shoulderLandmark.x - hipLandmark.x,
      );

  double degrees = radiansShoulderHip * 180.0 / math.pi;
  degrees +=180;
  if(degrees<0){
    degrees+=360;
  }
  //degrees = degrees.abs(); // Angle should never be negative
  degrees =360-degrees;

  return degrees;
}

double angleWristElbowShoulderLeft(
    PoseLandmark wristLandmark,
    PoseLandmark elbowLandmark,
    PoseLandmark shoulderLandmark,
    ) {
  final radiansWristElbow = math.atan2(
    elbowLandmark.y - shoulderLandmark.y,
    elbowLandmark.x - shoulderLandmark.x,
  ) -
      math.atan2(
        wristLandmark.y - elbowLandmark.y,
        wristLandmark.x - elbowLandmark.x,
      );

  double degrees = radiansWristElbow * 180.0 / math.pi;
  degrees +=180;
  if(degrees<0){
    degrees+=360;
  }
  degrees = degrees.abs(); // Angle should never be negative
  return degrees;
}

double angleWristElbowShoulderRight(
    PoseLandmark wristLandmark,
    PoseLandmark elbowLandmark,
    PoseLandmark shoulderLandmark,
    ) {
  final radiansWristElbow = math.atan2(
    elbowLandmark.y - shoulderLandmark.y,
    elbowLandmark.x - shoulderLandmark.x,
  ) -
      math.atan2(
        wristLandmark.y - elbowLandmark.y,
        wristLandmark.x - elbowLandmark.x,
      );

  double degrees = radiansWristElbow * 180.0 / math.pi;
  degrees +=180;
  if(degrees<0){
    degrees+=360;
  }

  degrees =360-degrees;
  degrees = degrees.abs(); // Angle should never be negative
  return degrees;
}

double angleHipKneeAnkleLeft(
    PoseLandmark hipLandmark,
    PoseLandmark kneeLandmark,
    PoseLandmark ankleLandmark,
    ) {
  final radiansHipKnee = math.atan2(
    kneeLandmark.y - ankleLandmark.y,
    kneeLandmark.x - ankleLandmark.x,
  ) -
      math.atan2(
        hipLandmark.y - kneeLandmark.y,
        hipLandmark.x - kneeLandmark.x,
      );

  double degrees = radiansHipKnee * 180.0 / math.pi;
  degrees +=180;
  if(degrees<0){
    degrees+=360;
  }

  return degrees;
}

double angleHipKneeAnkleRight(
    PoseLandmark hipLandmark,
    PoseLandmark kneeLandmark,
    PoseLandmark ankleLandmark,
    ) {
  final radiansHipKnee = math.atan2(
    kneeLandmark.y - ankleLandmark.y,
    kneeLandmark.x - ankleLandmark.x,
  ) -
      math.atan2(
        hipLandmark.y - kneeLandmark.y,
        hipLandmark.x - kneeLandmark.x,
      );

  double degrees = radiansHipKnee * 180.0 / math.pi;
  degrees +=180;
  if(degrees<0){
    degrees+=360;
  }
  //degrees = degrees.abs(); // Angle should never be negative
  degrees =360-degrees;

  return degrees;
}

PoseState isHandsOnHipPose(
    double rightShoulderAngle,
    double leftShoulderAngle,
    double rightElbowAngle,
    double leftElbowAngle,
    PoseState current,
    ) {
  final threshold = 10.0; // Adjust this threshold as needed

  if (current == PoseState.neutral &&
      (rightShoulderAngle > (55 - threshold) &&
          rightShoulderAngle < (55 + threshold)) &&
      (leftShoulderAngle > (55 - threshold) &&
          leftShoulderAngle < (55 + threshold)) &&
      (leftElbowAngle >(100-threshold) && leftElbowAngle <(100+threshold)) &&
      (rightElbowAngle >(100-threshold) && rightElbowAngle <(100+threshold))
  ) {
    return PoseState.correct; // Transition to 'correct' state for the desired pose
  } else if (current == PoseState.correct &&
      ((rightShoulderAngle <= (55 - threshold) ||
          rightShoulderAngle >= (55 + threshold)) ||
          (leftShoulderAngle <= (55 - threshold) ||
              leftShoulderAngle >= (55 + threshold)) ||
        (leftElbowAngle <=(100-threshold) || leftElbowAngle >=(100+threshold)) ||
      (rightElbowAngle <=(100-threshold) || rightElbowAngle >=(100+threshold)))
  ) {
    return PoseState.neutral; // Return to 'neutral' if the pose alignment is lost
  }

  return current; // Return current state if conditions are not met
}

PoseState isOpenArmPose(
    double rightShoulderAngle,
    double leftShoulderAngle,
    double rightElbowAngle,
    double leftElbowAngle,
    PoseState current,
    ) {
  final threshold = 10.0; // Adjust this threshold as needed

  if (current == PoseState.neutral &&
      (rightShoulderAngle > (48 - threshold) &&
          rightShoulderAngle < (48 + threshold)) &&
      (leftShoulderAngle > (48 - threshold) &&
          leftShoulderAngle < (48 + threshold)) &&
      (leftElbowAngle >(250-threshold) && leftElbowAngle <(250+threshold)) &&
      (rightElbowAngle >(110-threshold) && rightElbowAngle <(110+threshold))
  ) {
    return PoseState.correct; // Transition to 'correct' state for the desired pose
  } else if (current == PoseState.correct &&
      ((rightShoulderAngle <= (48 - threshold) ||
          rightShoulderAngle >= (48 + threshold)) ||
          (leftShoulderAngle <= (48 - threshold) ||
              leftShoulderAngle >= (48 + threshold)) ||
          (leftElbowAngle <=(250-threshold) || leftElbowAngle >=(250+threshold)) ||
          (rightElbowAngle <=(110-threshold) || rightElbowAngle >=(110+threshold)))
  ) {
    return PoseState.neutral; // Return to 'neutral' if the pose alignment is lost
  }

  return current; // Return current state if conditions are not met
}

PoseState isHandsOnHeadPose(
    double rightElbowRightShoulderRightHipAngle,
    double rightWristRightElbowRightShoulderAngle,
    double rightHipRightKneeRightAnkleAngle,
    double leftElbowLeftShoulderLeftHipAngle,
    double leftHipLeftKneeLeftAnkleAngle,
    PoseState current,
    ) {
  final threshold = 15.0; // Adjust this threshold as needed

  if (current==PoseState.neutral &&
      (rightElbowRightShoulderRightHipAngle >(135 - threshold) && rightElbowRightShoulderRightHipAngle <(135 + threshold)) &&
      (rightHipRightKneeRightAnkleAngle >(210 - threshold) && rightHipRightKneeRightAnkleAngle <(210 + threshold)) &&
      (leftElbowLeftShoulderLeftHipAngle >(25 - threshold) && leftElbowLeftShoulderLeftHipAngle <(25 + threshold)) &&
      (leftHipLeftKneeLeftAnkleAngle >(180 - threshold) && rightElbowRightShoulderRightHipAngle <(180 + threshold))
  ) {
    return PoseState.correct; // Transition to 'correct' state for the desired pose
  } else if (current==PoseState.correct &&
      (rightElbowRightShoulderRightHipAngle <=(135 - threshold) || rightElbowRightShoulderRightHipAngle >=(135 + threshold)) ||
      (rightHipRightKneeRightAnkleAngle <=(210 - threshold) || rightHipRightKneeRightAnkleAngle >=(210 + threshold)) ||
      (leftElbowLeftShoulderLeftHipAngle <=(25 - threshold) || leftElbowLeftShoulderLeftHipAngle >=(25 + threshold)) ||
      (leftHipLeftKneeLeftAnkleAngle <=(180 - threshold) || rightElbowRightShoulderRightHipAngle >=(180 + threshold))
  ) {
    return PoseState.neutral; // Return to 'neutral' if the pose alignment is lost
  }

  return current; // Return current state if conditions are not met
}

PoseState isDapPose(
    double rightElbowRightShoulderRightHipAngle,
    double rightWristRightElbowRightShoulderAngle,
    double rightShoulderRightHipRightKneeAngle,
    double rightHipRightKneeRightAnkleAngle,
    double leftElbowLeftShoulderLeftHipAngle,
    double leftWristLeftElbowLeftShoulderAngle,
    double leftShoulderLeftHipLeftKneeAngle,
    double leftHipLeftKneeLeftAnkleAngle,
    PoseState current,
    ) {
  final threshold = 20.0; // Adjust this threshold as needed

  if (current==PoseState.neutral &&
      (rightElbowRightShoulderRightHipAngle >(90 - threshold) && rightElbowRightShoulderRightHipAngle <(90 + threshold)) &&
      (rightWristRightElbowRightShoulderAngle >(180 - threshold) && rightWristRightElbowRightShoulderAngle <(180 + threshold)) &&
      (rightShoulderRightHipRightKneeAngle >(195 - threshold) && rightShoulderRightHipRightKneeAngle <(195 + threshold)) &&
      (rightHipRightKneeRightAnkleAngle >(150 - threshold) && rightHipRightKneeRightAnkleAngle <(150 + threshold)) &&
      (leftElbowLeftShoulderLeftHipAngle >(130 - threshold) && leftElbowLeftShoulderLeftHipAngle <(130 + threshold)) &&
     (leftWristLeftElbowLeftShoulderAngle >(330 - threshold) && leftWristLeftElbowLeftShoulderAngle <(330 + threshold)) &&
      (leftShoulderLeftHipLeftKneeAngle >(105 - threshold) && leftShoulderLeftHipLeftKneeAngle <(105 + threshold)) &&
      (leftHipLeftKneeLeftAnkleAngle >(210 - threshold) && rightElbowRightShoulderRightHipAngle <(210 + threshold))
  ) {
    return PoseState.correct; // Transition to 'correct' state for the desired pose
  } else if (current==PoseState.correct &&
      (rightElbowRightShoulderRightHipAngle <=(90 - threshold) || rightElbowRightShoulderRightHipAngle >=(90 + threshold)) ||
      (rightWristRightElbowRightShoulderAngle <=(180 - threshold) || rightWristRightElbowRightShoulderAngle >=(180 + threshold)) ||
      (rightShoulderRightHipRightKneeAngle <=(195 - threshold) || rightShoulderRightHipRightKneeAngle >=(195 + threshold)) ||
      (rightHipRightKneeRightAnkleAngle <=(150 - threshold) || rightHipRightKneeRightAnkleAngle >=(150 + threshold)) ||
      (leftElbowLeftShoulderLeftHipAngle <=(130 - threshold) || leftElbowLeftShoulderLeftHipAngle >=(130 + threshold)) ||
      (leftWristLeftElbowLeftShoulderAngle <=(330 - threshold) || leftWristLeftElbowLeftShoulderAngle >=(330 + threshold)) ||
      (leftShoulderLeftHipLeftKneeAngle <=(105 - threshold) || leftShoulderLeftHipLeftKneeAngle >=(105 + threshold)) ||
      (leftHipLeftKneeLeftAnkleAngle <=(210 - threshold) || rightElbowRightShoulderRightHipAngle >=(210 + threshold))
  ) {
    return PoseState.neutral; // Return to 'neutral' if the pose alignment is lost
  }

  return current; // Return current state if conditions are not met
}
