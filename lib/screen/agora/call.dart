import 'package:bloc_auth/utils/settings.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'dart:async';

class CallPage extends StatefulWidget {
  final String? channelName;
  final ClientRoleType? role;
  const CallPage({super.key, this.channelName, this.role});

  @override
  State<CallPage> createState() => _CallPageState();
}
late RtcEngine _engine;

class _CallPageState extends State<CallPage> {
  final _users = <int>[];
  final _infoString = <String>[];
  bool muted = false;
  bool viewPanel = false;



  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    _users.clear();
    _engine.leaveChannel();
    super.dispose();
  }

  Future<void> _initialize() async {
    // Step 1: Create Agora engine instance
    _engine = createAgoraRtcEngine();

    // Step 2: Initialize Agora engine with App ID
    await _engine.initialize(
      const RtcEngineContext(appId: appId),
    );

    // Step 3: Enable video
    await _engine.enableVideo();

    // Step 4: Set the channel profile (live broadcasting or communication)
    await _engine
        .setChannelProfile(ChannelProfileType.channelProfileLiveBroadcasting);

    // Step 5: Set the user role (broadcaster or audience)
    await _engine.setClientRole(role: widget.role!);

    // Step 6: Event Handler
    _addAgoraEventHandlers();

    // Step 7: Join the channel
    await _engine.joinChannel(
        token: token, channelId: widget.channelName!, uid: 0, options: const ChannelMediaOptions());
  }

  void _addAgoraEventHandlers() {
    // Handling Agora RTC events
    _engine.onError = (ErrorCodeType code, String message) {
      setState(() {
        final info = 'Error $code: $message';
        _infoString.add(info);
      });
    };

    _engine.onJoinChannelSuccess = (RtcConnection connection, int elapsed) {
      setState(() {
        final info = 'Join Channel Success: ${connection.localUid}';
        _infoString.add(info);
      });
    };

    _engine.onLeaveChannel = () {
      setState(() {
        _infoString.add('Leave Channel');
        _users.clear();
      });
    };

    _engine.onUserJoined = (RtcConnection connection, int remoteUid, int elapsed) {
      setState(() {
        final info = 'User Joined: $remoteUid';
        _infoString.add(info);
        _users.add(remoteUid);
      });
    };

    _engine.onUserOffline = (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
      setState(() {
        final info = 'User Offline: $remoteUid';
        _infoString.add(info);
        _users.remove(remoteUid);
      });
    };

    _engine.onFirstRemoteVideoFrame = (int uid, int width, int height, int elapsed) {
      setState(() {
        final info = 'First Remote Video: $uid, $width x $height';
        _infoString.add(info);
      });
    };
  }

  Widget _viewRow() {
    final List<Widget> list = [];
    if (widget.role == ClientRoleType.clientRoleBroadcaster) {
      // Add local video view
      list.add(AgoraRenderWidget(
        0,
        local: true,
        channelId: widget.channelName!,
      ));
    }

    // Add remote video views for each user
    for (var uid in _users) {
      list.add(AgoraRenderWidget(
        uid,
        local: false,
        channelId: widget.channelName!,
      ));
    }

    // Wrap the views with Expanded widgets and return as Column
    return Column(
      children: List.generate(
        list.length,
            (index) => Expanded(child: list[index]),
      ),
    );
  }

  Widget _toolbar() {
    if (widget.role == ClientRoleType.clientRoleAudience) return const SizedBox();
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {
              setState(() {
                muted = !muted;
              });
              _engine.muteLocalAudioStream(muted);
            },
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blue,
              size: 20,
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.red,
            padding: const EdgeInsets.all(15.0),
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35,
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              _engine.switchCamera();
            },
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
            child: const Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _panel() {
    return Visibility(
      visible: viewPanel,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 48),
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(
          heightFactor: 0.5,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: ListView.builder(
              itemCount: _infoString.length,
              reverse: true,
              itemBuilder: (BuildContext context, int index) {
                if (_infoString.isEmpty) {
                  return const Text('Null');
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            _infoString[index],
                            style: const TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Agora'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                viewPanel = !viewPanel;
              });
            },
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            _viewRow(),
            _panel(),
            _toolbar(),
          ],
        ),
      ),
    );
  }
}

extension on RtcEngine {
  set onUserOffline(Null Function(RtcConnection connection, int remoteUid, UserOfflineReasonType reason) onUserOffline) {}

  set onUserJoined(Null Function(RtcConnection connection, int remoteUid, int elapsed) onUserJoined) {}

  set onLeaveChannel(Null Function() onLeaveChannel) {}

  set onFirstRemoteVideoFrame(Null Function(int uid, int width, int height, int elapsed) onFirstRemoteVideoFrame) {}

  set onJoinChannelSuccess(Null Function(RtcConnection connection, int elapsed) onJoinChannelSuccess) {}

  set onError(Null Function(ErrorCodeType code, String message) onError) {}
}

class AgoraRenderWidget extends StatelessWidget {
  final int uid;
  final bool local;
  final String channelId;

  const AgoraRenderWidget(
      this.uid, {
        super.key,
        required this.local,
        required this.channelId,
      });

  @override
  Widget build(BuildContext context) {
    // Render either local or remote video based on the `local` flag
    return local ? _localVideo() : _remoteVideo();
  }

  // Local video rendering using the Agora SDK
  Widget _localVideo() {
    return AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: _engine,
        canvas: const VideoCanvas(uid: 0),
      ),
    );
  }

  // Remote video rendering for each user
  Widget _remoteVideo() {
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: _engine,
        canvas: VideoCanvas(uid: uid),
        connection: RtcConnection(channelId: channelId, localUid: uid),
      ),
    );
  }
}
