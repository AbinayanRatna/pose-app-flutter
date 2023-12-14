import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:linear_timer/linear_timer.dart';
import '../painters/pose_painter.dart';
import 'detector_view.dart';

class PoseDetectorView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PoseDetectorViewState();
}

class _PoseDetectorViewState extends State<PoseDetectorView> {
  final PoseDetector _poseDetector =
      PoseDetector(options: PoseDetectorOptions());
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  PosePainter? _posePainter;
  var _showWidget = false;

  var _cameraLensDirection = CameraLensDirection.back;

  @override
  void dispose() async {
    _canProcess = false;
    _poseDetector.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        _showWidget = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showWidget
        ? DetectorView(
            posePainter: _posePainter,
            title: 'Pose Detector',
            customPaint: _customPaint,
            text: _text,
            onImage: _processImage,
            initialCameraLensDirection: _cameraLensDirection,
            onCameraLensDirectionChanged: (value) =>
                _cameraLensDirection = value,
          )
        : _instructions();
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final poses = await _poseDetector.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = PosePainter(
        poses,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
      _posePainter = painter;
    } else {
      _text = 'Poses found: ${poses.length}\n\n';
      // TODO: set _customPaint to draw landmarks on top of image
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  Widget _instructions() {
    return ScreenUtilInit(
      minTextAdapt: true,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/pose7.svg",height: 250.h,),
            Padding(
              padding: EdgeInsets.fromLTRB(40.w,20.w,40.w,30.w),
              child: Text("Keep the phone at eye level",
                  style: TextStyle(fontSize: 20.w,color: Colors.black,fontWeight: FontWeight.w500),),
            ),
             Padding(
              padding:  EdgeInsets.fromLTRB(20.w,0,20.w,0),
              child:  const LinearTimer(duration: Duration(seconds: 4),color: Colors.blue,),
            )
          ],
        ),
      ),
    );
  }
}
