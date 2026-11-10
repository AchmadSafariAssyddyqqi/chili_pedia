class SprayLogModel {
  final String id;
  final String targetName; // e.g. Antraknosa (Patek)
  final String pesticideName; // e.g. Mankozeb 80WP
  final String dosageInfo; // e.g. 32 gram / 2 tangki (16L)
  final DateTime sprayDate;
  final DateTime nextScheduleDate;
  final String note;

  SprayLogModel({
    required this.id,
    required this.targetName,
    required this.pesticideName,
    required this.dosageInfo,
    required this.sprayDate,
    required this.nextScheduleDate,
    required this.note,
  });
}

