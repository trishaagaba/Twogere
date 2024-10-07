import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_better_camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:twongere/main.dart';
import 'package:twongere/routes/camera_sample/test_camera.dart';
import 'package:twongere/routes/home_screen/navigations/home_nav/tabs/text_trans_tab/widgets/text_trans_tab_widgets.dart';
import 'package:twongere/util/app_colors.dart';
import 'package:twongere/util/app_styles.dart';
import 'package:video_player/video_player.dart';

class TextTransTab extends StatefulWidget{
  const TextTransTab({super.key});

  @override
  _textTransTab createState ()=> _textTransTab();

}



class _textTransTab extends State<TextTransTab> with WidgetsBindingObserver{

  final TextEditingController _firstController = TextEditingController();
  bool _isStreaming = true;
  CameraController? controller;
  String? imagePath;
  late String videoPath;
  VideoPlayerController? videoController;
  VideoPlayerController _videoController = VideoPlayerController.asset("assets/videos/earthena.mp4");
  late VoidCallback videoPlayerListener;
  bool enableAudio = true;
  FlashMode flashMode = FlashMode.off;

  int cameraIndex = 0;

  @override
  void initState() {
    super.initState();

    _videoController.play();
    _videoController.setLooping(true);
    WidgetsBinding.instance!.addObserver(this);  //<<-----should be uncommented
    onNewCameraSelected(cameras[cameraIndex]);  //<<-----should be uncommented
  }

  @override
  void dispose(){
    WidgetsBinding.instance!.removeObserver(this);
    _firstController.dispose();
    super.dispose();

    _videoController.dispose();
  }

    @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller!.value.isInitialized!) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        onNewCameraSelected(controller!.description);
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
              Container(
                // width: 250,
                // constraints: const BoxConstraints.expand(height: 400),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.bgGreyColor
                ),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Stack(
                  children: [
                    _isStreaming? //<<----- should be uncommented
                    // ZoomableWidget(
                    //     child: 
                        cameraPreviewWidget() //<<------should be uncommented
                        // onTapUp: (scaledPoint) {
                        //   //controller.setPointOfInterest(scaledPoint);
                        // },
                        // onZoom: (zoom) {
                        //   print('zoom');
                        //   if (zoom < 11) {
                        //     controller!.zoom(zoom);
                        //   }
                        // }
                        // )
                        : //<<------should be uncommented
                        Container(
                          color: AppColors.bgGreyColor,
                          constraints: const BoxConstraints.expand(height: 400),
                          child: FutureBuilder(
                            future: _videoController.initialize(), 
                            builder: (context, snapshot) {
                              
                              if(snapshot.connectionState == ConnectionState.done){
                                _videoController.play();
                                return
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0), // Set your desired border radius here
                                      child: VideoPlayer(_videoController),);
                              }

                              if(snapshot.hasError){
                                return const Text("Error loading video");
                              }

                              return const Center(
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }, ),
                        ), 
                      
                    // const SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child:SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: (){
                              setState(() {
                                _isStreaming= !_isStreaming;
                                
                              });
                            }, 
                            icon: _isStreaming? 
                            const Icon(Icons.stop, color: AppColors.primarColor,): const Icon(Icons.play_arrow, color: AppColors.primarColor)),

                          TextButton(
                            onPressed: (){
                              setState(() {
                                if(cameras.length>0){
                                  cameraIndex = cameraIndex==0? 1:0;
                                  onNewCameraSelected(cameras[cameraIndex]);
                                }
                              });
                            }, 
                            child: cameraIndex==0? 
                            const Icon(Icons.video_camera_back, color: AppColors.primarColor,): const Icon(Icons.video_camera_front, color: AppColors.primarColor)),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
              // const TxtTransTop(), //<<-- should be uncommented
              !_isStreaming? FirstTxt(controller: _firstController):
              const TranslatedTextWidget(
                text: "Collect and analyze market sentiment data from various sources, such as investor surveys, news sentiment analysis, and social media sentiment analysis. Collect and analyze market sentiment data from various sources, such as investor surveys, news sentiment analysis, and social media sentiment analysis.", 
                language: "English")
          ],
        ),
      ), 
    );
  }

/// Display the preview from the camera (or a message if the preview is not available).
  Widget cameraPreviewWidget() {
    if (controller == null || !controller!.value.isInitialized!) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: AspectRatio(
          aspectRatio: controller!.value.aspectRatio,
          child: CameraPreview(controller!),
                ),
        );
      
      
      // Container(
      //   constraints: const BoxConstraints.expand(),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(15)
      //   ),
      //   // padding: const EdgeInsets.all(5),
      //   child: CameraPreview(controller!),
      // );
    }
  }

  /// Toggle recording audio
  Widget _toggleAudioWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Row(
        children: <Widget>[
          const Text('Enable Audio:'),
          Switch(
            value: enableAudio,
            onChanged: (bool value) {
              enableAudio = value;
              if (controller != null) {
                onNewCameraSelected(controller!.description);
              }
            },
          ),
        ],
      ),
    );
  }

  /// Display the thumbnail of the captured image or video.
  Widget _thumbnailWidget() {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            videoController == null && imagePath == null
                ? Container()
                : SizedBox(
                    child: (videoController == null)
                        ? Image.file(File(imagePath!))
                        : Container(
                            child: Center(
                              child: AspectRatio(
                                  aspectRatio:
                                      videoController!.value.size != null
                                          ? videoController!.value.aspectRatio
                                          : 1.0,
                                  child: VideoPlayer(videoController!)),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.pink)),
                          ),
                    width: 64.0,
                    height: 64.0,
                  ),
          ],
        ),
      ),
    );
  }

  /// Display the control bar with buttons to take pictures and record videos.
  Widget _captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.camera_alt),
          color: Colors.blue,
          onPressed: controller != null &&
                  controller!.value.isInitialized! &&
                  !controller!.value.isRecordingVideo!
              ? onTakePictureButtonPressed
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          color: Colors.blue,
          onPressed: controller != null &&
                  controller!.value.isInitialized! &&
                  !controller!.value.isRecordingVideo!
              ? onVideoRecordButtonPressed
              : null,
        ),
        IconButton(
          icon: controller != null && controller!.value.isRecordingPaused
              ? Icon(Icons.play_arrow)
              : Icon(Icons.pause),
          color: Colors.blue,
          onPressed: controller != null &&
                  controller!.value.isInitialized! &&
                  controller!.value.isRecordingVideo!
              ? (controller != null && controller!.value.isRecordingPaused
                  ? onResumeButtonPressed
                  : onPauseButtonPressed)
              : null,
        ),
        IconButton(
          icon: controller != null && controller!.value.autoFocusEnabled!
              ? Icon(Icons.access_alarm)
              : Icon(Icons.access_alarms),
          color: Colors.blue,
          onPressed: (controller != null && controller!.value.isInitialized!)
              ? toogleAutoFocus
              : null,
        ),
        _flashButton(),
        IconButton(
          icon: const Icon(Icons.stop),
          color: Colors.red,
          onPressed: controller != null &&
                  controller!.value.isInitialized! &&
                  controller!.value.isRecordingVideo!
              ? onStopButtonPressed
              : null,
        ),
      ],
    );
  }

  /// Flash Toggle Button
  Widget _flashButton() {
    IconData iconData = Icons.flash_off;
    Color color = Colors.black;
    if (flashMode == FlashMode.alwaysFlash) {
      iconData = Icons.flash_on;
      color = Colors.blue;
    } else if (flashMode == FlashMode.autoFlash) {
      iconData = Icons.flash_auto;
      color = Colors.red;
    }
    return IconButton(
      icon: Icon(iconData),
      color: color,
      onPressed: controller != null && controller!.value.isInitialized!
          ? _onFlashButtonPressed
          : null,
    );
  }

  /// Toggle Flash
  Future<void> _onFlashButtonPressed() async {
    bool hasFlash = false;
    if (flashMode == FlashMode.off || flashMode == FlashMode.torch) {
      // Turn on the flash for capture
      flashMode = FlashMode.alwaysFlash;
    } else if (flashMode == FlashMode.alwaysFlash) {
      // Turn on the flash for capture if needed
      flashMode = FlashMode.autoFlash;
    } else {
      // Turn off the flash
      flashMode = FlashMode.off;
    }
    // Apply the new mode
    await controller!.setFlashMode(flashMode);

    // Change UI State
    setState(() {});
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraTogglesRowWidget() {
    final List<Widget> toggles = <Widget>[];

    if (cameras.isEmpty) {
      return const Text('No camera found');
    } else {
      for (CameraDescription cameraDescription in cameras) {
        toggles.add(
          SizedBox(
            width: 90.0,
            child: RadioListTile<CameraDescription>(
              title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
              groupValue: controller?.description,
              value: cameraDescription,
              onChanged: controller != null && controller!.value.isRecordingVideo!
                  ? null
                  : onNewCameraSelected,
            ),
          ),
        );
      }
    }

    return Row(children: toggles);
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    // _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(message)));
  }

  void onNewCameraSelected(CameraDescription? cameraDescription) async {
    if (controller != null) {
      await controller!.dispose();
    }
    controller = CameraController(
      cameraDescription!,
      ResolutionPreset.medium,
      enableAudio: enableAudio,
    );

    // If the controller is updated then update the UI.
    controller!.addListener(() {
      if (mounted) setState(() {});
      if (controller!.value.hasError) {
        showInSnackBar('Camera error ${controller!.value.errorDescription}');
      }
    });

    try {
      await controller!.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((String? filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
          videoController?.dispose();
          videoController = null;
        });
        if (filePath != null) showInSnackBar('Picture saved to $filePath');
      }
    });
  }

  void onVideoRecordButtonPressed() {
    startVideoRecording().then((String? filePath) {
      if (mounted) setState(() {});
      if (filePath != null) showInSnackBar('Saving video to $filePath');
    });
  }

  void onStopButtonPressed() {
    stopVideoRecording().then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Video recorded to: $videoPath');
    });
  }

  void onPauseButtonPressed() {
    pauseVideoRecording().then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Video recording paused');
    });
  }

  void onResumeButtonPressed() {
    resumeVideoRecording().then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Video recording resumed');
    });
  }

  void toogleAutoFocus() {
    controller!.setAutoFocus(!controller!.value.autoFocusEnabled!);
    showInSnackBar('Toogle auto focus');
  }

  Future<String?> startVideoRecording() async {
    if (!controller!.value.isInitialized!) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Movies/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.mp4';

    if (controller!.value.isRecordingVideo!) {
      // A recording is already started, do nothing.
      return null;
    }

    try {
      videoPath = filePath;
      await controller!.startVideoRecording(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  Future<void> stopVideoRecording() async {
    if (!controller!.value.isRecordingVideo!) {
      return null;
    }

    try {
      await controller!.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    await _startVideoPlayer();
  }

  Future<void> pauseVideoRecording() async {
    if (!controller!.value.isRecordingVideo!) {
      return null;
    }

    try {
      await controller!.pauseVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> resumeVideoRecording() async {
    if (!controller!.value.isRecordingVideo!) {
      return null;
    }

    try {
      await controller!.resumeVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> _startVideoPlayer() async {
    final VideoPlayerController vcontroller =
        VideoPlayerController.file(File(videoPath));
    videoPlayerListener = () {
      if (videoController != null && videoController!.value.size != null) {
        // Refreshing the state to update video player with the correct ratio.
        if (mounted) setState(() {});
        videoController!.removeListener(videoPlayerListener);
      }
    };
    vcontroller.addListener(videoPlayerListener);
    await vcontroller.setLooping(true);
    await vcontroller.initialize();
    await videoController?.dispose();
    if (mounted) {
      setState(() {
        imagePath = null;
        videoController = vcontroller;
      });
    }
    await vcontroller.play();
  }

  Future<String?> takePicture() async {
    if (!controller!.value.isInitialized!) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller!.value.isTakingPicture!) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller!.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
  
}