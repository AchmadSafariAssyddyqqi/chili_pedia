import 'package:flutter/material.dart';
import '../models/spray_log_model.dart';

class SprayLogService extends ChangeNotifier {
  static final SprayLogService _instance = SprayLogService._internal();
  factory SprayLogService() => _instance;
  SprayLogService._internal() {
    // Initial sample record to demonstrate to lecturer
    _logs.add(
      SprayLogModel(
        id: 'sample_1',
        targetName: 'Antraknosa (Patek)',
        pesticideName: 'Fungisida Mankozeb 80WP',
        dosageInfo: '32 gr / tangki 16L (2 tangki)',
        sprayDate: DateTime.now().subtract(const Duration(days: 3)),
        nextScheduleDate: DateTime.now().add(const Duration(days: 4)),
        note: 'Penyemprotan rutin pencegahan musim hujan blok bedengan A.',
      ),
    );
  }

  final List<SprayLogModel> _logs = [];

  List<SprayLogModel> get logs => List.unmodifiable(_logs);

  void addLog(SprayLogModel log) {
    _logs.insert(0, log);
    notifyListeners();
  }

  void removeLog(String id) {
    _logs.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  int get count => _logs.length;
}

