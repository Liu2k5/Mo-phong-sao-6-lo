import 'package:flutter/foundation.dart';
import 'package:flutter_soloud/flutter_soloud.dart';

class ToneEngine {
  ToneEngine._();
  static final ToneEngine instance = ToneEngine._();

  final SoLoud _soloud = SoLoud.instance;
  AudioSource? _source;
  SoundHandle? _handle;
  bool _audible = false;

  bool get isReady => _source != null;

  Future<void> init() async {
    if (_soloud.isInitialized) return;
    await _soloud.init(lowLatency: true); // mặc định đã là true
    // triangle nghe gần giống sáo hơn sin thuần
    _source = await _soloud.loadWaveform(WaveForm.triangle, false, 0.35, 0.0);
    // Mở sẵn một voice ở volume 0. Waveform là nguồn vô hạn nên cứ để nó chạy,
    // nhờ vậy lúc bắt đầu thổi không phải tạo voice mới -> độ trễ gần bằng 0.
    _handle = _soloud.play(_source!, volume: 0.0);
    debugPrint('ToneEngine ready: voices=${_soloud.getActiveVoiceCount()}');
  }

  /// Thổi nốt có tần số [hz].
  /// Gọi liên tục khi ngón tay đổi lỗ; nếu đang thổi thì chỉ đổi cao độ.
  void playAt(double hz) {
    if (hz <= 0) {
      stop();
      return;
    }

    final src = _source;
    final h = _handle;
    if (src == null || h == null) {
      debugPrint('ToneEngine chưa init, bỏ qua $hz Hz');
      return;
    }

    _soloud.setWaveformFreq(src, hz);

    if (!_audible) {
      // fade vào nhanh để tránh tiếng "pop"
      _soloud.fadeVolume(h, 0.4, const Duration(milliseconds: 25));
      _audible = true;
    }
  }

  /// Nhả ra: tắt tiếng nhưng giữ voice để lần sau thổi lại tức thì.
  void stop() {
    final h = _handle;
    if (h == null || !_audible) return;
    _soloud.fadeVolume(h, 0.0, const Duration(milliseconds: 40));
    _audible = false;
  }

  Future<void> dispose() async {
    await _soloud.disposeAllSources();
    _soloud.deinit();
  }
}