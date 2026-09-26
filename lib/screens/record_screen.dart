import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  final AudioRecorder _recorder = AudioRecorder(); // record package
  final AudioPlayer _player = AudioPlayer(); // audioplayers package

  bool _isRecording = false;
  bool _isPlaying = false;

  String? _audioPath;

  @override
  void initState() {
    super.initState();
    // Registered once here instead of inside _playRecording, so repeated
    // plays don't stack up duplicate listeners.
    _player.onPlayerComplete.listen((_) {
      if (mounted) setState(() => _isPlaying = false);
    });
  }

  @override
  void dispose() {
    _recorder.dispose();
    _player.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    final hasPermission = await _recorder.hasPermission();
    if (!hasPermission) {
      _showMessage('Microphone permission is required.');
      return;
    }

    final dir = await getApplicationDocumentsDirectory();
    final path =
        '${dir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';

    await _recorder.start(const RecordConfig(), path: path);

    setState(() {
      _isRecording = true;
      _audioPath =
          null; // hide "Play Audio" while a new recording is in progress
    });
  }

  Future<void> _stopRecording() async {
    final path = await _recorder.stop();
    setState(() {
      _isRecording = false;
      _audioPath = path;
    });
  }

  Future<void> _playRecording() async {
    if (_audioPath == null) return;

    setState(() => _isPlaying = true);
    await _player.play(DeviceFileSource(_audioPath!));
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voice Recorder'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              child: Text(_isRecording ? 'Stop Recording' : 'Record Audio'),
            ),
            if (_audioPath != null && !_isRecording) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isPlaying ? null : _playRecording,
                child: Text(_isPlaying ? 'Playing...' : 'Play Audio'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
