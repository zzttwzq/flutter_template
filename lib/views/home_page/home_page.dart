import 'package:app/ui/custom_appbar.dart';
import 'package:app/utils/ui_util.dart';
// import 'package:app/views/components/text_form.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with BaseUiMixin {
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();

  RTCPeerConnection? _localPeerConnection;
  RTCPeerConnection? _remotePeerConnection;
  RTCRtpSender? _audioSender;
  RTCRtpCapabilities? acaps;
  RTCRtpCapabilities? vcaps;
  MediaStream? _localStream;
  List<MediaStream> _remoteStreams = [];

  final _configuration = <String, dynamic>{
    'iceServers': [
      {'urls': 'stun:stun.l.google.com:19302'},
    ],
    'sdpSemantics': 'unified-plan',
    'encodedInsertableStreams': true,
  };

  final _constraints = <String, dynamic>{
    'mandatory': {},
    'optional': [
      {'DtlsSrtpKeyAgreement': false},
    ],
  };

  @override
  void initState() {
    super.initState();

    initRenderers();
    _refreshMediaDevices();

    Future.delayed(const Duration(seconds: 1), () {
      _makeCall();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.noBackAppBar(),
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                GestureDetector(
                  child: Container(
                    width: 100,
                    height: 30,
                    color: Colors.orange,
                    child: const Text(
                      "start",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  onTap: () async {
                    _startAudio();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: Text("stop"),
                  onTap: () async {
                    _stopAudio();
                  },
                ),
                Container(
                  color: Colors.red,
                  width: 100,
                  height: 100,
                  child: RTCVideoView(_localRenderer, mirror: true),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> initRenderers() async {
    await _localRenderer.initialize();
  }

  Map<String, dynamic> _getMediaConstraints({audio = true, video = true}) {
    return {
      'audio': audio ? true : false,
      'video': video
          ? {
              'mandatory': {
                'minWidth': '640',
                'minHeight': '480',
                'minFrameRate': '30',
              },
              'facingMode': 'user',
              'optional': [],
            }
          : false,
    };
  }

  void _startAudio() async {
    var newStream = await navigator.mediaDevices
        .getUserMedia(_getMediaConstraints(audio: true, video: false));

    // final storagePath = await getExternalStorageDirectory();
    // if (storagePath == null) throw Exception('Can\'t find storagePath');

    // final filePath = storagePath.path + '/webrtc_sample/test.mp4';
    // MediaRecorder mediaRecorder = MediaRecorder();
    // setState(() {});

    // final audioTran = _localStream!
    //     .getAudioTracks()
    //     .firstWhere((track) => track.kind == 'audio');

    // await mediaRecorder!.start(
    //   filePath,
    //   // videoTrack: videoTrack,
    //   // audioChannel: newStream.get
    // );

    if (_localStream != null) {
      await _removeExistingAudioTrack();
      for (var newTrack in newStream.getAudioTracks()) {
        await _localStream!.addTrack(newTrack);
      }
    } else {
      _localStream = newStream;
    }

    // 拦截媒体流
    _localStream?.getAudioTracks().forEach((track) {
      print('Audio track: ${track.id}');
      // await track.onEnded
    });

    _localStream?.getVideoTracks().forEach((track) {
      print('Video track: ${track.id}');
    });

    await _addOrReplaceAudioTracks();
    var transceivers = await _localPeerConnection?.getTransceivers();
    transceivers?.forEach((transceiver) {
      if (transceiver.sender.senderId != _audioSender?.senderId) return;
      var codecs = acaps?.codecs
              ?.where((element) =>
                  element.mimeType.toLowerCase().contains("PCMA".toLowerCase()))
              .toList() ??
          [];
      transceiver.setCodecPreferences(codecs);
    });
    await _negotiate();
    // setState(() {
    //   _micOn = true;
    // });
  }

  void _stopAudio() async {
    _localRenderer.srcObject = null;
  }

  Future<void> _removeExistingAudioTrack({bool fromConnection = false}) async {
    var tracks = _localStream!.getAudioTracks();
    for (var i = tracks.length - 1; i >= 0; i--) {
      var track = tracks[i];
      if (fromConnection) {
        await _connectionRemoveTrack(track);
      }
      await _localStream!.removeTrack(track);
      await track.stop();
    }
  }

  Future<void> _addOrReplaceAudioTracks() async {
    for (var track in _localStream!.getAudioTracks()) {
      await _connectionAddTrack(track, _localStream!);
    }
  }

  Future<void> _connectionAddTrack(
      MediaStreamTrack track, MediaStream stream) async {
    var sender = _audioSender;
    if (sender != null) {
      print('Have a Sender of kind:${track.kind}');
      var trans = await _getSendersTransceiver(sender.senderId);
      if (trans != null) {
        print('Setting direction and replacing track with new track');
        await trans.setDirection(TransceiverDirection.SendOnly);
        await trans.sender.replaceTrack(track);
      }
    } else {
      _audioSender = await _localPeerConnection!.addTrack(track, stream);
    }
  }

  Future<void> _connectionRemoveTrack(MediaStreamTrack track) async {
    var sender = _audioSender;
    if (sender != null) {
      print('Have a Sender of kind:${track.kind}');
      var trans = await _getSendersTransceiver(sender.senderId);
      if (trans != null) {
        print('Setting direction and replacing track with null');
        await trans.setDirection(TransceiverDirection.Inactive);
        await trans.sender.replaceTrack(null);
      }
    }
  }

  Future<RTCRtpTransceiver?> _getSendersTransceiver(String senderId) async {
    RTCRtpTransceiver? foundTrans;
    var trans = await _localPeerConnection!.getTransceivers();
    for (var tran in trans) {
      if (tran.sender.senderId == senderId) {
        foundTrans = tran;
        break;
      }
    }
    return foundTrans;
  }

  Future<void> _negotiate() async {
    final oaConstraints = <String, dynamic>{
      'mandatory': {
        'OfferToReceiveAudio': true,
        'OfferToReceiveVideo': true,
      },
      'optional': [],
    };

    if (_remotePeerConnection == null) return;

    var offer = await _localPeerConnection!.createOffer({});
    await _localPeerConnection!.setLocalDescription(offer);
    var localDescription = await _localPeerConnection!.getLocalDescription();

    await _remotePeerConnection!.setRemoteDescription(localDescription!);
    var answer = await _remotePeerConnection!.createAnswer(oaConstraints);
    await _remotePeerConnection!.setLocalDescription(answer);
    var remoteDescription = await _remotePeerConnection!.getLocalDescription();

    await _localPeerConnection!.setRemoteDescription(remoteDescription!);
  }

  Future<void> _refreshMediaDevices() async {
    var devices = await navigator.mediaDevices.enumerateDevices();
    // setState(() {
    //   _mediaDevicesList = devices;
    // });
  }

  void _selectAudioOutput(String deviceId) async {
    await _localRenderer.audioOutput(deviceId);
  }

  void _selectAudioInput(String deviceId) async {
    await Helper.selectAudioInput(deviceId);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void _makeCall() async {
    initRenderers();
    initLocalConnection();

    // var keyProviderOptions = KeyProviderOptions(
    //   sharedKey: true,
    //   ratchetSalt: Uint8List.fromList(demoRatchetSalt.codeUnits),
    //   ratchetWindowSize: 16,
    //   failureTolerance: -1,
    // );

    // _keySharedProvider ??=
    //     await _frameCyrptorFactory.createDefaultKeyProvider(keyProviderOptions);
    // await _keySharedProvider?.setSharedKey(key: aesKey);
    acaps = await getRtpSenderCapabilities('audio');
    print('sender audio capabilities: ${acaps!.toMap()}');

    vcaps = await getRtpSenderCapabilities('video');
    print('sender video capabilities: ${vcaps!.toMap()}');

    if (_remotePeerConnection != null) return;

    try {
      var pc = await createPeerConnection(_configuration, _constraints);
      pc.onTrack = _onTrack;

      pc.onSignalingState = (state) async {
        var state2 = await pc.getSignalingState();
        print('remote pc: onSignalingState($state), state2($state2)');
      };

      pc.onIceGatheringState = (state) async {
        var state2 = await pc.getIceGatheringState();
        print('remote pc: onIceGatheringState($state), state2($state2)');
      };

      pc.onIceConnectionState = (state) async {
        var state2 = await pc.getIceConnectionState();
        print('remote pc: onIceConnectionState($state), state2($state2)');
      };

      pc.onConnectionState = (state) async {
        var state2 = await pc.getConnectionState();
        print('remote pc: onConnectionState($state), state2($state2)');
      };

      pc.onAddStream = (state) async {
        print('remote pc: onAddStream($state)');
      };

      pc.onIceCandidate = _onRemoteCandidate;
      pc.onRenegotiationNeeded = _onRemoteRenegotiationNeeded;
      _remotePeerConnection = pc;

      await _negotiate();
    } catch (e) {
      print(e.toString());
    }

    if (!mounted) return;
    // setState(() {
    //   _inCalling = true;
    // });

    print("make call compelete");
  }

  void initLocalConnection() async {
    if (_localPeerConnection != null) return;
    try {
      var pc = await createPeerConnection(_configuration, _constraints);

      pc.onSignalingState = (state) async {
        var state2 = await pc.getSignalingState();
        print('local pc: onSignalingState($state), state2($state2)');
      };

      pc.onIceGatheringState = (state) async {
        var state2 = await pc.getIceGatheringState();
        print('local pc: onIceGatheringState($state), state2($state2)');
      };
      pc.onIceConnectionState = (state) async {
        var state2 = await pc.getIceConnectionState();
        print('local pc: onIceConnectionState($state), state2($state2)');
      };
      pc.onConnectionState = (state) async {
        var state2 = await pc.getConnectionState();
        print('local pc: onConnectionState($state), state2($state2)');
      };
      pc.onDataChannel = (RTCDataChannel dataChannel) {
        // _dataChannel = dataChannel;
        dataChannel.onMessage = (RTCDataChannelMessage message) {
          print('Received message: ${message.text}');
        };
      };

      pc.onIceCandidate = _onLocalCandidate;
      pc.onRenegotiationNeeded = _onLocalRenegotiationNeeded;

      _localPeerConnection = pc;
    } catch (e) {
      print(e.toString());
    }
  }

  void _onTrack(RTCTrackEvent event) async {
    print('onTrack ${event.track.id}');

    if (event.track.kind == 'video') {
      setState(() {
        _remoteRenderer.srcObject = event.streams[0];
      });
    }
  }

  void _onLocalCandidate(RTCIceCandidate localCandidate) async {
    print('onLocalCandidate: ${localCandidate.candidate}');
    try {
      var candidate = RTCIceCandidate(
        localCandidate.candidate!,
        localCandidate.sdpMid!,
        localCandidate.sdpMLineIndex!,
      );
      await _remotePeerConnection!.addCandidate(candidate);
    } catch (e) {
      print(
          'Unable to add candidate ${localCandidate.candidate} to remote connection');
    }
  }

  void _onRemoteCandidate(RTCIceCandidate remoteCandidate) async {
    print('onRemoteCandidate: ${remoteCandidate.candidate}');
    try {
      var candidate = RTCIceCandidate(
        remoteCandidate.candidate!,
        remoteCandidate.sdpMid!,
        remoteCandidate.sdpMLineIndex!,
      );
      await _localPeerConnection!.addCandidate(candidate);
    } catch (e) {
      print(
          'Unable to add candidate ${remoteCandidate.candidate} to local connection');
    }
  }

  void _onLocalRenegotiationNeeded() {
    print('LocalRenegotiationNeeded');
  }

  void _onRemoteRenegotiationNeeded() {
    print('RemoteRenegotiationNeeded');
  }
}
