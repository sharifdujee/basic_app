import 'package:bloc_auth/screen/agora/call.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'dart:developer';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

final _channelController = TextEditingController();
var _validateError = false;
ClientRoleType _role = ClientRoleType.clientRoleBroadcaster;

class _IndexPageState extends State<IndexPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Agora Index'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Image.network('https://tinyurl.com/2p889y4k'),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _channelController,
                  decoration: InputDecoration(
                    errorText:
                        _validateError ? 'Channel name is Required' : null,
                    border:
                        UnderlineInputBorder(borderSide: BorderSide(width: 1)),
                    hintText: 'Channel Name',
                  ),
                ),
                RadioListTile(
                    title: const Text('Broadcaster'),
                    value: ClientRoleType.clientRoleBroadcaster,
                    groupValue: _role,
                    onChanged: (ClientRoleType? value) {
                      setState(() {
                        _role = value!;
                      });
                    }),
                RadioListTile(
                    title: const Text('Audience'),
                    value: ClientRoleType.clientRoleAudience,
                    groupValue: _role,
                    onChanged: (ClientRoleType? value) {
                      setState(() {
                        _role = value!;
                      });
                    }),
                ElevatedButton(
                  onPressed: onJoin,
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40)),
                  child: const Text('Join'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    setState(() {
      _channelController.text.isEmpty ? _validateError = true : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text,
            role: _role,
          ),
        ),
      );
    }
  }


  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    log(status.toString());
  }
}
