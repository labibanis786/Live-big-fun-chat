import 'dart:async';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

const String appId = '739a61014ae64d2eaf7dd9eb4872664e'; // Replace with your Agora App ID if different
// For simplicity this demo uses Temporary token disabled mode. For production use a token server.
const String token = ''; // optional: insert a token if your Agora project requires it
const String channelName = 'demo_channel';

class VoiceRoomPage extends StatefulWidget {
  final String channel;
  const VoiceRoomPage({Key? key, this.channel = channelName}) : super(key: key);

  @override
  State<VoiceRoomPage> createState() => _VoiceRoomPageState();
}

class _VoiceRoomPageState extends State<VoiceRoomPage> {
  int? _localUid;
  final Map<int, bool> _remoteUsers = {};
  bool _joined = false;
  bool _muted = false;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    await AgoraRtcEngine.createWithConfig(RtcEngineContext(appId));
    await AgoraRtcEngine.enableAudio();
    AgoraRtcEngine.onJoinChannelSuccess = (connection, elapsed) {
      setState(() {
        _joined = true;
        _localUid = connection.localUid;
      });
    };
    AgoraRtcEngine.onUserJoined = (connection, remoteUid, elapsed) {
      setState(() { _remoteUsers[remoteUid] = true; });
    };
    AgoraRtcEngine.onUserOffline = (connection, remoteUid, reason) {
      setState(() { _remoteUsers.remove(remoteUid); });
    };
    // Join channel (no token used here - ensure your project allows this or generate a token)
    await AgoraRtcEngine.joinChannel(token, widget.channel, null, 0);
  }

  @override
  void dispose() {
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    super.dispose();
  }

  void _toggleMute() {
    setState(() { _muted = !_muted; });
    AgoraRtcEngine.muteLocalAudioStream(_muted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voice Room')),
      body: Column(
        children: [
          ListTile(
            title: Text('Channel: ' + widget.channel),
            subtitle: Text(_joined ? 'Connected' : 'Connecting...'),
            trailing: ElevatedButton(
              onPressed: _toggleMute,
              child: Text(_muted ? 'Unmute' : 'Mute'),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Local UID: ' + (_localUid?.toString() ?? '-')),
          ),
          Expanded(
            child: ListView(
              children: _remoteUsers.keys.map((uid) =>
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text('User ' + uid.toString()),
                  subtitle: const Text('Speaking...'),
                )
              ).toList(),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            icon: const Icon(Icons.exit_to_app),
            label: const Text('Leave Room'),
            onPressed: () { Navigator.of(context).pop(); },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
