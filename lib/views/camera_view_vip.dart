import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:pose_detection_app/models/pose_one_model.dart' as model;
import 'package:pose_detection_app/painters/pose_painter.dart';
import 'package:pose_detection_app/utils.dart' as utils;
import 'package:fluttertoast/fluttertoast.dart';
import '../main.dart';
import '../notification_service.dart';

class CameraViewVip extends StatefulWidget {
  CameraViewVip(
      {Key? key,
      this.index,
      required this.customPaint,
      required this.onImage,
      required this.posePainter,
      this.onCameraFeedReady,
      this.onDetectorViewModeChanged,
      this.onCameraLensDirectionChanged,
      this.initialCameraLensDirection = CameraLensDirection.back})
      : super(key: key);

  final int? index;
  final PosePainter? posePainter;
  final CustomPaint? customPaint;
  final Function(InputImage inputImage) onImage;
  final VoidCallback? onCameraFeedReady;
  final VoidCallback? onDetectorViewModeChanged;
  final Function(CameraLensDirection direction)? onCameraLensDirectionChanged;
  final CameraLensDirection initialCameraLensDirection;

  @override
  State<CameraViewVip> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraViewVip> {
  static List<CameraDescription> _cameras = [];
  CameraController? _controller;
  int _cameraIndex = -1;
  double _currentZoomLevel = 1.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _currentExposureOffset = 0.0;
  bool _changingCameraLens = false;
  bool _voiceEnable = false;
  bool _autoCapture = false;
  double _angleLeftShoulder = 0.0;
  double _angleLeftElbow = 0.0;
  double _angleLeftHip = 0.0;
  double _angleLeftKnee = 0.0;
  double _angleRightShoulder = 0.0;
  double _angleRightElbow = 0.0;
  double _angleRightHip = 0.0;
  double _angleRightKnee = 0.0;
  String poseTextFinal = "";
  int numCorrectPoses=0;

  PoseLandmark? p1;
  PoseLandmark? p2;
  PoseLandmark? p3;
  PoseLandmark? p4;

  //FlutterTts flutterTts = FlutterTts();

  late FlutterTts flutterTts;
  String speechBubbleText = '';
  String speechBubbleTextAdd = '';
  List<Widget> actions = [];
  bool alreadyDelayed = false;

  //String poseText2='';

  @override
  void initState() {
    super.initState();

    _initialize();
    initTts();
  }

  initTts() async {
    flutterTts = FlutterTts();

    await flutterTts.awaitSpeakCompletion(true);
    await speakFeedback();
  }

  void _initialize() async {
    if (_cameras.isEmpty) {
      _cameras = await availableCameras();
    }
    for (var i = 0; i < _cameras.length; i++) {
      if (_cameras[i].lensDirection == widget.initialCameraLensDirection) {
        _cameraIndex = i;
        break;
      }
    }
    if (_cameraIndex != -1) {
      _startLiveFeed();
    }
  }

  @override
  void didUpdateWidget(covariant CameraViewVip oldWidget) {
    if (widget.customPaint != oldWidget.customPaint) {
      if (widget.customPaint == null) return;
      final poseDetector = BlocProvider.of<model.PoseDetector>(context);
      for (final pose in widget.posePainter!.poses) {
        PoseLandmark getPoseLandmark(PoseLandmarkType type1) {
          final PoseLandmark joint1 = pose.landmarks[type1]!;
          return joint1;
        }

        final elbowLeft = getPoseLandmark(PoseLandmarkType.leftElbow);
        final shoulderLeft = getPoseLandmark(PoseLandmarkType.leftShoulder);
        final hipLeft = getPoseLandmark(PoseLandmarkType.leftHip);
        final wristLeft = getPoseLandmark(PoseLandmarkType.leftWrist);
        final kneeLeft = getPoseLandmark(PoseLandmarkType.leftKnee);
        final ankleLeft = getPoseLandmark(PoseLandmarkType.leftAnkle);

        final elbowRight = getPoseLandmark(PoseLandmarkType.rightElbow);
        final shoulderRight = getPoseLandmark(PoseLandmarkType.rightShoulder);
        final hipRight = getPoseLandmark(PoseLandmarkType.rightHip);
        final wristRight = getPoseLandmark(PoseLandmarkType.rightWrist);
        final kneeRight = getPoseLandmark(PoseLandmarkType.rightKnee);
        final ankleRight = getPoseLandmark(PoseLandmarkType.rightAnkle);

        if (elbowLeft != null &&
            shoulderLeft != null &&
            hipLeft != null &&
            elbowRight != null &&
            shoulderRight != null &&
            hipRight != null &&
            wristRight != null &&
            wristLeft != null &&
            kneeRight != null &&
            kneeLeft != null &&
            ankleRight != null &&
            ankleLeft != null) {
          final angleLeftShoulder = utils.angleElbowShoulderHipLeft(
            elbowLeft,
            shoulderLeft,
            hipLeft,
          );

          final angleLeftHip = utils.angleShoulderHipKneeLeft(
            shoulderLeft,
            hipLeft,
            kneeLeft,
          );

          final angleLeftKnee = utils.angleHipKneeAnkleLeft(
            hipLeft,
            kneeLeft,
            ankleLeft,
          );

          final angleLeftElbow = utils.angleWristElbowShoulderLeft(
            wristLeft,
            elbowLeft,
            shoulderLeft,
          );

          final angleRightShoulder = utils.angleElbowShoulderHipRight(
            elbowRight,
            shoulderRight,
            hipRight,
          );

          final angleRightHip = utils.angleShoulderHipKneeRight(
            shoulderRight,
            hipRight,
            kneeRight,
          );

          final angleRightKnee = utils.angleHipKneeAnkleRight(
            hipRight,
            kneeRight,
            ankleRight,
          );

          final angleRightElbow = utils.angleWristElbowShoulderRight(
            wristRight,
            elbowRight,
            shoulderRight,
          );

          // bool right_ShoulderCorrect=false,left_ShoulderCorrect=false,right_ElbowCorrect=false,left_ElbowCorrect=false;
          final bloc = BlocProvider.of<model.PoseDetector>(context);

          //Timer.periodic(Duration(seconds: 2), (timer) {

          // });
          void speakText(String text) async {
            await flutterTts.speak(text);
          }

          void stopSpeaking() async {
            await flutterTts.stop();
          }

          String poseText3 = "";

          if (widget.index == 0) {
            if (_angleRightShoulder <= 28 || _angleRightShoulder >= 68) {
              if (_angleRightShoulder <= 28) {
                poseText3 = "Increase the interior angle at right shoulder";
              } else if (_angleRightShoulder >= 68) {
                poseText3 = "Decrease the interior angle at right shoulder";
              }
            } else if (_angleLeftShoulder <= 28 || _angleLeftShoulder >= 68) {
              if (_angleLeftShoulder <= 28) {
                poseText3 = "Increase the interior angle at left shoulder";
              } else if (_angleLeftShoulder >= 68) {
                poseText3 = "Decrease the interior angle at left shoulder";
              }
            } else if (_angleRightElbow <= 90 || _angleRightElbow >= 130) {
              if (_angleRightElbow <= 90) {
                poseText3 = "Increase the interior angle at right elbow";
              } else if (_angleRightElbow >= 130) {
                poseText3 = "Decrease the interior angle at right elbow";
              }
            } else if (_angleLeftElbow <= 230 || _angleLeftElbow >= 270) {
              if (_angleLeftElbow <= 230) {
                poseText3 = "Decrease the interior angle at left elbow";
              } else if (_angleLeftElbow >= 270) {
                poseText3 = "Increase the interior angle at left elbow";

              }
            } else if (bloc.state == model.PoseState.correct) {
              poseText3 = "Correct pose";
              numCorrectPoses++;
            }
          }
          else if (widget.index == 1) {
            if (_angleRightShoulder <= 120 || _angleRightShoulder >= 150) {
              if (_angleRightShoulder <= 120) {
                poseText3 = "Increase the interior angle at right shoulder";
              } else if (_angleRightShoulder >= 150) {
                poseText3 = "Decrease the interior angle at right shoulder";
              }
            } else if (_angleLeftShoulder <= 10 || _angleLeftShoulder >= 40) {
              if (_angleLeftShoulder <= 10) {
                poseText3 = "Increase the interior angle at left shoulder";
              } else if (_angleLeftShoulder >= 40) {
                poseText3 = "Decrease the interior angle at left shoulder";
              }
            } else if (_angleRightKnee <= 195 || _angleRightKnee >= 225) {
              if (_angleRightKnee <= 195) {
                poseText3 = "Increase the interior angle at right knee";
              } else if (_angleRightKnee >= 225) {
                poseText3 = "Decrease the interior angle at right knee";
              }
            } else if (_angleLeftKnee <= 165 || _angleLeftKnee >= 195) {
              if (_angleLeftKnee <= 165) {
                poseText3 = "Decrease the interior angle at left knee";
              } else if (_angleLeftKnee >= 195) {
                poseText3 = "Increase the interior angle at left knee";
              }
            } else if (bloc.state == model.PoseState.correct) {
              poseText3 = "Correct pose";
              numCorrectPoses++;
            }
          }
          else if (widget.index == 2) {
            if (_angleRightShoulder <= 70 || _angleRightShoulder >= 110) {
              if (_angleRightShoulder <= 70) {
                poseText3 = "Increase the interior angle at right shoulder";
              } else if (_angleRightShoulder >= 110) {
                poseText3 = "Decrease the interior angle at right shoulder";
              }
            }   else if (_angleRightElbow <= 160 || _angleRightElbow >= 200) {
              if (_angleRightElbow <= 160) {
                poseText3 = "Increase the interior angle at right elbow";
              } else if (_angleRightElbow >= 200) {
                poseText3 = "Decrease the interior angle at right elbow";
              }
            } else if (_angleLeftShoulder <= 110 || _angleLeftShoulder >= 150) {
              if (_angleLeftShoulder <= 110) {
                poseText3 = "Increase the interior angle at left shoulder";
              } else if (_angleLeftShoulder >= 150) {
                poseText3 = "Decrease the interior angle at left shoulder";
              }
            }  else if (_angleLeftElbow <= 310 || _angleLeftElbow >= 350) {
              if (_angleLeftElbow <= 165) {
                poseText3 = "Increase the interior angle at left elbow";
              } else if (_angleLeftElbow >= 195) {
                poseText3 = "Decrease the interior angle at left elbow";
              }
            } else if (bloc.state == model.PoseState.correct) {
              poseText3 = "Correct pose";
              numCorrectPoses++;
            }
          }
          else if (widget.index == 3) {
            if (_angleRightShoulder <= 45 || _angleRightShoulder >= 65) {
              if (_angleRightShoulder <= 45) {
                poseText3 = "Increase the interior angle at right shoulder";
              } else if (_angleRightShoulder >= 65) {
                poseText3 = "Decrease the interior angle at right shoulder";
              }
            } else if (_angleLeftShoulder <= 45 || _angleLeftShoulder >= 65) {
              if (_angleLeftShoulder <= 45) {
                poseText3 = "Increase the interior angle at left shoulder";
              } else if (_angleLeftShoulder >= 65) {
                poseText3 = "Decrease the interior angle at left shoulder";
              }
            } else if (_angleLeftElbow <= 90 || _angleLeftElbow >= 110) {
              if (_angleLeftElbow <= 90) {
                poseText3 = "Increase the interior angle at left elbow";
              } else if (_angleLeftElbow >= 110) {
                poseText3 = "Decrease the interior angle at left elbow";
              }
            } else if (_angleRightElbow <= 90 || _angleRightElbow >= 110) {
              if (_angleRightElbow <= 90) {
                poseText3 = "Increase the interior angle at right elbow";
              } else if (_angleRightElbow >= 110) {
                poseText3 = "Decrease the interior angle at right elbow";
              }
            } else if (bloc.state == model.PoseState.correct) {
              poseText3 = "Correct pose";
              numCorrectPoses++;
            }
          }

          speechBubbleTextAdd = poseText3;

          setState(() {
            _angleLeftShoulder = angleLeftShoulder;
            _angleLeftElbow = angleLeftElbow;
            _angleLeftHip = angleLeftHip;
            _angleLeftKnee = angleLeftKnee;
            _angleRightShoulder = angleRightShoulder;
            _angleRightElbow = angleRightElbow;
            _angleRightHip = angleRightHip;
            _angleRightKnee = angleRightKnee;
            poseTextFinal = poseText3;
            if (_autoCapture && numCorrectPoses>=5) {
              _autoCapture=!_autoCapture;
              numCorrectPoses=0;
              takePictureAuto(); // Restart speaking if voice is re-enabled
            }
          });

          var poseState = utils.isOpenArmPose(
            angleRightShoulder,
            angleLeftShoulder,
            angleRightElbow,
            angleLeftElbow,
            poseDetector.state,
          );

          if (widget.index == 0) {
            poseState = utils.isOpenArmPose(
              angleRightShoulder,
              angleLeftShoulder,
              angleRightElbow,
              angleLeftElbow,
              poseDetector.state,
            );
            //    poseText2 = "is open arm";
          } else if (widget.index == 1) {
            poseState = utils.isHandsOnHeadPose(
              angleRightShoulder,
              angleRightElbow,
              angleRightKnee,
              angleLeftShoulder,
              angleLeftKnee,
              poseDetector.state,
            );
            //  poseText2 = "is hand on head ";
          } else if (widget.index == 2) {
            poseState = utils.isDapPose(
              angleRightShoulder,
              angleRightElbow,
              angleRightHip,
              angleRightKnee,
              angleLeftShoulder,
              angleLeftElbow,
              angleLeftHip,
              angleLeftKnee,
              poseDetector.state,
            );
            // poseText2 = "is dap pose";
          } else if (widget.index == 3) {
            poseState = utils.isHandsOnHipPose(
              angleRightShoulder,
              angleLeftShoulder,
              angleRightElbow,
              angleLeftElbow,
              poseDetector.state,
            );
            //poseText2 = "is hands on hip";
          }

          if (poseState != null && poseState == model.PoseState.correct) {
            // Pose is nearly 90 degrees on both sides, handle the state change or any actions here
            poseDetector.setPoseState(poseState);
          } else {
            // Pose doesn't match the desired angle, handle the state change or any actions here
            poseDetector.setPoseState(model.PoseState.neutral);
          }
        }
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _liveFeedBody());
  }

  Widget _liveFeedBody() {
    if (_cameras.isEmpty) return Container();
    if (_controller == null) return Container();
    if (_controller?.value.isInitialized == false) return Container();
    return ScreenUtilInit(
      minTextAdapt: true,
      child: Container(
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Center(
              child: _changingCameraLens
                  ? Center(
                child: const Text('Changing camera lens'),
              )
                  : CameraPreview(
                _controller!,
                child: widget.customPaint,
              ),
            ),
            _resultsWidget(),
            _takePicture(),
            _switchLiveCameraToggle(),
            _zoomControl(),
            _exposureControl(),
            _muteVoiceFeedback(),
            _autoTakePicture()
          ],
        ),
      ),
    );
  }

  Widget _resultsWidget() {
    final bloc = BlocProvider.of<model.PoseDetector>(context);
    String poseText = '';
    //''+'leftelbow : ${_angleLeftElbow.toStringAsFixed(1)} '+'lefthip : ${_angleLeftHip.toStringAsFixed(1)} '+'leftknee : ${_angleLeftKnee.toStringAsFixed(1)} ';
    bool isPoseCorrect = false;
    // Determine the text to display based on the pose state
    switch (bloc.state) {
      case model.PoseState.correct:
        poseText = 'Correct Pose';
        isPoseCorrect = true;
        break;
      case model.PoseState.incorrect:
        poseText = 'Incorrect Pose';
        isPoseCorrect = false;
        break;
      case model.PoseState.neutral:
        poseText = 'neutral Pose';
        break;
    // Add other cases if needed for different states
    }

    String poseText2 =
        'rightShoulder : ${_angleRightShoulder.toStringAsFixed(0)} \n' +
            'leftShoulder : ${_angleLeftShoulder.toStringAsFixed(0)} \n' +
            'rightelbow : ${_angleRightElbow.toStringAsFixed(0)} \n' +
            'leftelbow : ${_angleLeftElbow.toStringAsFixed(0)}  \n' +
            'leftelHip : ${_angleLeftHip.toStringAsFixed(0)}  \n' +
            'righthip : ${_angleRightHip.toStringAsFixed(0)}  \n' +
            'rightknee : ${_angleRightKnee.toStringAsFixed(0)}  \n' +
            'leftknee: ${_angleLeftKnee.toStringAsFixed(0)}  \n' +
            poseText;
    /*
   poseState = utils.isOpenArmPose(
              angleRightShoulder,
              angleLeftShoulder,
              angleRightElbow,
              angleLeftElbow,
              poseDetector.state,
            );
    */

    // String poseText2='rightShoulder : ${_angleRightSholuderLeftHip.toStringAsFixed(0)} \n'+'leftShoulder : ${_angleLeftShoulderRightHip.toStringAsFixed(0)} \n';
    return Positioned(
      left: 0,
      top: 80.w,
      right: 0,
      child: Container(
        width: 80.w,
        child: Column(
          children: [
            Container(
              width: 200.w,
              decoration: BoxDecoration(
                color: Colors.black54,
                border: Border.all(
                  color: Colors.white.withOpacity(0.4),
                  width: 4.0.w,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Text(
                poseTextFinal,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isPoseCorrect ? Colors.white : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _takePicture() =>
      Positioned(
        bottom: 10.w,
        left: MediaQuery
            .of(context)
            .size
            .width / 2.w,
        child: SizedBox(
          height: 50.0.w,
          width: 50.0.w,
          child: FloatingActionButton(
            heroTag: Object(),
            onPressed: takePicture,
            backgroundColor: Colors.black54,
            child: Icon(
              Icons.camera,
              size: 35.w,
            ),
          ),
        ),
      );

  Widget _switchLiveCameraToggle() =>
      Positioned(
        bottom: 10.w,
        right: 30.w,
        child: SizedBox(
          height: 50.0.w,
          width: 50.0.w,
          child: FloatingActionButton(
            heroTag: Object(),
            onPressed: _switchLiveCamera,
            backgroundColor: Colors.black54,
            child: Icon(
              Platform.isIOS
                  ? Icons.flip_camera_ios_outlined
                  : Icons.flip_camera_android_outlined,
              size: 35.w,
            ),
          ),
        ),
      );

  Widget _muteVoiceFeedback() =>
      Positioned(
        bottom: 10.w,
        left: 30.w,
        child: SizedBox(
          height: 50.0.w,
          width: 50.0.w,
          child: FloatingActionButton(
            heroTag: Object(),
            onPressed: _voiceEnableFunction,
            backgroundColor: (_voiceEnable)?Colors.white:Colors.black54,
            child: Icon(
              (_voiceEnable)?Icons.volume_up_rounded:Icons.volume_off_rounded,
              size: 35.w,color:(_voiceEnable)?Colors.black:Colors.white ,
            ),
          ),
        ),
      );

  Widget _zoomControl() =>
      Positioned(
        bottom: 90.w,
        left: 0,
        right: 0,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 250.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Slider(
                    value: _currentZoomLevel,
                    min: _minAvailableZoom,
                    max: _maxAvailableZoom,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white30,
                    onChanged: (value) async {
                      setState(() {
                        _currentZoomLevel = value;
                      });
                      await _controller?.setZoomLevel(value);
                    },
                  ),
                ),
                Container(
                  width: 50.w,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: Center(
                      child: Text(
                        '${_currentZoomLevel.toStringAsFixed(1)}x',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _autoTakePicture() => Positioned(
    top: 250.w,
    right: 10.w,
    child: SizedBox(
      height: 50.0.w,
      width: 50.0.w,
      child: FloatingActionButton(
        heroTag: Object(),
        onPressed:(){
          _autoCapture = !_autoCapture;
        },
        backgroundColor: (_autoCapture)?Colors.white:Colors.black54,
        child: Icon(
          (_autoCapture)?Icons.slow_motion_video_outlined:Icons.motion_photos_paused_sharp,
          color:(_autoCapture)?Colors.black:Colors.white,
          size: 35.w,
        ),
      ),
    ),
  );


  Widget _exposureControl() =>
      Positioned(
        top: 40,
        right: 8,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 250,
          ),
          child: Column(children: [
            Container(
              width: 55,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "${_currentExposureOffset.toStringAsFixed(1)}x",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: RotatedBox(
                quarterTurns: 3,
                child: SizedBox(
                  height: 30,
                  child: Slider(
                    value: _currentExposureOffset,
                    min: _minAvailableExposureOffset,
                    max: _maxAvailableExposureOffset,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white30,
                    onChanged: (value) async {
                      setState(() {
                        _currentExposureOffset = value;
                      });
                      await _controller?.setExposureOffset(value);
                    },
                  ),
                ),
              ),
            )
          ]),
        ),
      );

  Future _startLiveFeed() async {
    final camera = _cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      // Set to ResolutionPreset.high. Do NOT set it to ResolutionPreset.max because for some phones does NOT work.
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.getMinZoomLevel().then((value) {
        _currentZoomLevel = value;
        _minAvailableZoom = value;
      });
      _controller?.getMaxZoomLevel().then((value) {
        _maxAvailableZoom = value;
      });
      _currentExposureOffset = 0.0;
      _controller?.getMinExposureOffset().then((value) {
        _minAvailableExposureOffset = value;
      });
      _controller?.getMaxExposureOffset().then((value) {
        _maxAvailableExposureOffset = value;
      });
      _controller?.startImageStream(_processCameraImage).then((value) {
        if (widget.onCameraFeedReady != null) {
          widget.onCameraFeedReady!();
        }
        if (widget.onCameraLensDirectionChanged != null) {
          widget.onCameraLensDirectionChanged!(camera.lensDirection);
        }
      });
      setState(() {});
    });
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  Future _switchLiveCamera() async {
    setState(() => _changingCameraLens = true);
    _cameraIndex = (_cameraIndex + 1) % _cameras.length;

    await _stopLiveFeed();
    await _startLiveFeed();
    setState(() => _changingCameraLens = false);
  }

  void _voiceEnableFunction() {
    setState(() {
      print("test 1:" + _voiceEnable.toString());
      _voiceEnable = !_voiceEnable;
    });
    if (_voiceEnable) {
      speakFeedback(); // Restart speaking if voice is re-enabled
    }
  }

  void _processCameraImage(CameraImage image) {
    final inputImage = _inputImageFromCameraImage(image);
    if (inputImage == null) return;
    widget.onImage(inputImage);
  }

  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    if (_controller == null) return null;

    // get image rotation
    // it is used in android to convert the InputImage from Dart to Java: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/android/src/main/java/com/google_mlkit_commons/InputImageConverter.java
    // `rotation` is not used in iOS to convert the InputImage from Dart to Obj-C: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/ios/Classes/MLKVisionImage%2BFlutterPlugin.m
    // in both platforms `rotation` and `camera.lensDirection` can be used to compensate `x` and `y` coordinates on a canvas: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/example/lib/vision_detector_views/painters/coordinates_translator.dart
    final camera = _cameras[_cameraIndex];
    final sensorOrientation = camera.sensorOrientation;
    // print(
    //     'lensDirection: ${camera.lensDirection}, sensorOrientation: $sensorOrientation, ${_controller?.value.deviceOrientation} ${_controller?.value.lockedCaptureOrientation} ${_controller?.value.isCaptureOrientationLocked}');
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
      _orientations[_controller!.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
      // print('rotationCompensation: $rotationCompensation');
    }
    if (rotation == null) return null;
    // print('final rotation: $rotation');

    // get image format
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    // validate format depending on platform
    // only supported formats:
    // * nv21 for Android
    // * bgra8888 for iOS
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    // since format is constraint to nv21 or bgra8888, both only have one plane
    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    // compose InputImage using bytes
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }

  Future takePicture() async {
    if (!(_controller!).value.isInitialized) {
      return null;
    }
    if ((_controller!).value.isTakingPicture) {
      return null;
    }
    try {
      await (_controller!).setFlashMode(FlashMode.off);
      XFile picture = await (_controller!).takePicture();
      File imageFile = File(picture!.path);
      int currentUnix = DateTime
          .now()
          .millisecondsSinceEpoch;
    //  GallerySaver.saveImage(imageFile.path, albumName: "Pose app");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PreviewPage(
                picture: picture,
              ),
        ),
      );
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }
  Future takePictureAuto() async {
    if (!(_controller!).value.isInitialized) {
      return null;
    }
    if ((_controller!).value.isTakingPicture) {
      return null;
    }
    try {
      await (_controller!).setFlashMode(FlashMode.off);
      XFile picture = await (_controller!).takePicture();
      File imageFile = File(picture!.path);
      int currentUnix = DateTime
          .now()
          .millisecondsSinceEpoch;
    //  GallerySaver.saveImage(imageFile.path, albumName: "Pose app");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PreviewPage(
                picture: picture,
              ),
        ),
      );
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  Future<void> speakFeedback() async {
    bool isPoseCorrect = false;
    late bool isVoiceEnabledOrNor;
    isVoiceEnabledOrNor = _voiceEnable;
    bool isContiuing = true;
    while (_voiceEnable) {
      if (speechBubbleTextAdd == "Correct pose") {
        isPoseCorrect = true;
      }
      setState(() {
        speechBubbleText = speechBubbleTextAdd;
        actions = [];
        actions.add(Text('test'));
      });
      await flutterTts.speak(speechBubbleText);

      // If the pose is correct or voice is disabled, exit the loop
      if (isPoseCorrect || !_voiceEnable) {
        break;
      }
    }
  }
}

class PreviewPage extends StatelessWidget {
  PreviewPage({Key? key, required this.picture}) : super(key: key);
  NotificationService _notificationService = NotificationService();
  final XFile picture;
  bool isImageSaved = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Return false to disable back button
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Picture Preview"),
            backgroundColor: const Color.fromRGBO(19, 154, 157, 1.0),
          ),
          backgroundColor: const Color.fromRGBO(19, 154, 157, 1.0),
          body: Column(
            children: [
              Expanded(
                flex: 10,
                child: Center(
                  child: Column(children: [
                    Image.file(File(picture.path),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width),
                  ]),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left:90.w),
                        child: SizedBox(
                          height: 50.0.w,
                          width: 50.0.w,
                          child: FloatingActionButton(
                            heroTag: Object(),
                            onPressed: () async {
                              File imageFile = File(picture!.path);

                              GallerySaver.saveImage(imageFile.path,
                                  albumName: "Pose app")
                                  .onError((error, stackTrace) {
                                isImageSaved = false;
                                Fluttertoast.showToast(
                                    msg: "Error in saving",
                                    toastLength: Toast.LENGTH_SHORT);
                              });
                              if (isImageSaved) {
                                await _notificationService.showNotifications("Craftie","Image saved to gallery");
                              }
                            },
                            backgroundColor: const Color.fromRGBO(19, 154, 157, 1.0),
                            elevation: 0,
                            child: Icon(
                              Icons.save_alt,
                              size: 35.w,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:70.w),
                        child: SizedBox(
                          height: 50.0.w,
                          width: 50.0.w,
                          child: FloatingActionButton(
                            heroTag: Object(),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GuestPageHomeVip(),),(route) => false
                              );
                            },
                            backgroundColor: const Color.fromRGBO(19, 154, 157, 1.0),
                            elevation: 0,
                            child: Icon(
                              Icons.delete,
                              size: 35.w,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}