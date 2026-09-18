import 'package:flutter/material.dart';
import 'package:mophongsao6lo/pitch_match.dart';
import 'package:mophongsao6lo/tone_engine.dart';

class FluteBoard extends StatefulWidget {
  const FluteBoard({super.key});

  @override
  State<FluteBoard> createState() {
    return FluteBoardState();
  }
}

class FluteBoardState extends State<FluteBoard> {
  // 3 mức lực thổi: 0, 1, 2
  final List<bool> strengths = List<bool>.filled(3, false);
  // 6 lỗ: false = mở, true = bịt
  final List<bool> holes = List<bool>.filled(6, false);

  void setHole(int index, bool closed) {
    if (holes[index] == closed) return; // tránh setState thừa
    setState(() => holes[index] = closed);
  }

  void setStrength(int index, bool active) {
    if (strengths[index] == active) return; // tránh setState thừa
    setState(() {
      // Mức lực thổi là lựa chọn loại trừ nhau: chỉ một mức tại một thời điểm.
      // Nếu không, indexOf(true) sẽ luôn trả về nút có chỉ số nhỏ nhất và
      // người dùng giữ 2 nút sẽ vô tình nghe sai quãng tám.
      if (active) {
        for (var i = 0; i < strengths.length; i++) {
          strengths[i] = i == index;
        }
      } else {
        strengths[index] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
    Column(children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [for (int i = 0; i < 3; i++) _buildStrength(i)],
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [for (int i = 0; i < 6; i++) _buildHole(i)],
      )

    ],);
  }

  Widget _buildHole(int index) {
    final closed = holes[index];
    return Listener(
      onPointerDown: (_) {
        setHole(index, true);
        updatePitch();
      },
      onPointerUp: (_) {
        setHole(index, false);
        updatePitch();
      },
      onPointerCancel: (_) {
        setHole(index, false);
        updatePitch();
      },
      child: TextButton(
        onPressed: () {}, // giữ nút ở trạng thái enabled
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(const Size(400, 100)),
          backgroundColor: WidgetStateProperty.all(
            closed ? Colors.deepPurple : Colors.grey.shade300,
          ),
          foregroundColor: WidgetStateProperty.all(
            closed ? Colors.white : Colors.black87,
          ),
        ),
        child: Text('${index + 1}: ${closed ? 'BỊT' : 'MỞ'}'),
      ),
    );
  }

  Widget _buildStrength(int index) {
    final closed = strengths[index];
    return Listener(
      onPointerDown: (_) {
        setStrength(index, true);
        updatePitch(); // gọi hàm updatePitch khi nhấn nút
        },
      onPointerUp: (_) {
        setStrength(index, false);
        updatePitch(); // gọi hàm updatePitch khi nhả nút
      },
      onPointerCancel: (_) {
        setStrength(index, false);
        updatePitch(); // gọi hàm updatePitch khi hủy thao tác
      },
      child: TextButton(
        onPressed: () {}, // giữ nút ở trạng thái enabled
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(const Size(400, 40)),
          backgroundColor: WidgetStateProperty.all(
            closed ? Colors.deepPurple : Colors.grey.shade300,
          ),
          foregroundColor: WidgetStateProperty.all(
            closed ? Colors.white : Colors.black87,
          ),
        ),
        child: Text('${index + 1}'),
      ),
    );
  }

  void updatePitch() {
    // Lấy mức lực thổi
    final currentStrength = strengths.indexOf(true) + 1;
    if (currentStrength <= 0) {
      ToneEngine.instance.stop();
      return;
    }
    // Lấy danh sách các lỗ bịt
    final currentHoles = List<bool>.from(holes);
    // Lấy tên nốt nhạc dựa trên trạng thái lỗ
    final pitchName = PitchMatch.getPitchName(currentStrength, currentHoles);
    // Lấy tần số nốt nhạc dựa trên trạng thái lỗ
    final pitchFrequency = PitchMatch.getPitchFrequency(currentStrength, currentHoles);
    
    // playAt tự xử lý trường hợp không khớp nốt (tần số <= 0) bằng cách tắt tiếng
    ToneEngine.instance.playAt(pitchFrequency);

    debugPrint('holes=$currentHoles strength=$currentStrength '
        'note=$pitchName hz=$pitchFrequency');
  }
}
