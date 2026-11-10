import 'package:flutter/material.dart';
import '../data/chili_data.dart';
import '../models/spray_log_model.dart';
import '../services/spray_log_service.dart';

class SprayLogScreen extends StatefulWidget {
  const SprayLogScreen({super.key});

  @override
  State<SprayLogScreen> createState() => _SprayLogScreenState();
}

class _SprayLogScreenState extends State<SprayLogScreen> {
  final SprayLogService _service = SprayLogService();

  @override
  void initState() {
    super.initState();
    _service.addListener(_onServiceChanged);
  }

  @override
  void dispose() {
    _service.removeListener(_onServiceChanged);
    super.dispose();
  }

  void _onServiceChanged() {
    setState(() {});
  }

  String _formatDate(DateTime dt) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des'
    ];
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
  }

  void _showAddLogBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _AddSprayLogSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final logs = _service.logs;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text(
          'Jurnal Penyemprotan Kebun',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0xFF1B5E20),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: logs.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: logs.length,
              itemBuilder: (context, index) {
                final log = logs[index];
                return _buildLogCard(log);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddLogBottomSheet,
        backgroundColor: const Color(0xFF1B5E20),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Catat Semprot Baru',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.history_edu_rounded,
                size: 54,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Belum Ada Catatan Semprot',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Catat riwayat penyemprotan fungisida dan insektisida kebun cabai Anda agar jadwal pengendalian selalu terkontrol.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF6B7280),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _showAddLogBottomSheet,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'Buat Catatan Pertama',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B5E20),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogCard(SprayLogModel log) {
    final bool isUpcoming = log.nextScheduleDate.isAfter(DateTime.now());

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Target & Delete
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.water_drop,
                    color: Color(0xFF2E7D32),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        log.targetName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        log.pesticideName,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF059669),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Color(0xFF9CA3AF), size: 20),
                  tooltip: 'Hapus Catatan',
                  onPressed: () {
                    _service.removeLog(log.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Catatan penyemprotan dihapus.'),
                        duration: Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ],
            ),

            const Divider(height: 20),

            // Detail Info Badges
            Row(
              children: [
                Expanded(
                  child: _buildInfoItem(
                    label: 'Tanggal Semprot',
                    value: _formatDate(log.sprayDate),
                    icon: Icons.calendar_today_outlined,
                  ),
                ),
                Expanded(
                  child: _buildInfoItem(
                    label: 'Dosis Digunakan',
                    value: log.dosageInfo,
                    icon: Icons.science_outlined,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Next Schedule Banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isUpcoming ? const Color(0xFFFFFBEB) : const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isUpcoming ? const Color(0xFFFDE68A) : const Color(0xFFE5E7EB),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.event_repeat,
                    size: 16,
                    color: isUpcoming ? const Color(0xFFD97706) : const Color(0xFF6B7280),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Jadwal Semprot Berikutnya: ',
                    style: TextStyle(
                      fontSize: 12,
                      color: isUpcoming ? const Color(0xFF92400E) : const Color(0xFF4B5563),
                    ),
                  ),
                  Text(
                    _formatDate(log.nextScheduleDate),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isUpcoming ? const Color(0xFF92400E) : const Color(0xFF1F2937),
                    ),
                  ),
                ],
              ),
            ),

            if (log.note.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                'Catatan: ${log.note}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6B7280),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: const Color(0xFF9CA3AF)),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
            color: Color(0xFF374151),
          ),
        ),
      ],
    );
  }
}

class _AddSprayLogSheet extends StatefulWidget {
  const _AddSprayLogSheet();

  @override
  State<_AddSprayLogSheet> createState() => _AddSprayLogSheetState();
}

class _AddSprayLogSheetState extends State<_AddSprayLogSheet> {
  String _selectedTarget = ChiliData.items.first.name;
  final TextEditingController _pesticideController =
      TextEditingController(text: 'Mankozeb 80WP');
  final TextEditingController _dosageController =
      TextEditingController(text: '32 gr / tangki 16L');
  final TextEditingController _noteController = TextEditingController();

  DateTime _sprayDate = DateTime.now();
  int _intervalDays = 7;

  @override
  void dispose() {
    _pesticideController.dispose();
    _dosageController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _saveLog() {
    if (_pesticideController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama bahan / obat wajib diisi.')),
      );
      return;
    }

    final newLog = SprayLogModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      targetName: _selectedTarget,
      pesticideName: _pesticideController.text.trim(),
      dosageInfo: _dosageController.text.trim(),
      sprayDate: _sprayDate,
      nextScheduleDate: _sprayDate.add(Duration(days: _intervalDays)),
      note: _noteController.text.trim(),
    );

    SprayLogService().addLog(newLog);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Catatan penyemprotan berhasil disimpan!'),
        backgroundColor: Color(0xFF1B5E20),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tambah Catatan Penyemprotan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 16),

            // Dropdown Target Hama/Penyakit
            const Text(
              'Target Hama / Penyakit:',
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _selectedTarget,
                  items: ChiliData.items.map((item) {
                    return DropdownMenuItem(
                      value: item.name,
                      child: Text(
                        item.name,
                        style: const TextStyle(fontSize: 13.5),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedTarget = val);
                  },
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Nama Obat
            _buildTextField(
              controller: _pesticideController,
              label: 'Nama Bahan / Pestisida / Fungisida',
              hint: 'Misal Mankozeb, Abamektin, Petrogenol',
            ),

            const SizedBox(height: 14),

            // Dosis Digunakan
            _buildTextField(
              controller: _dosageController,
              label: 'Takaran Dosis & Jumlah Tangki',
              hint: 'Misal 32 gram / 2 tangki (16L)',
            ),

            const SizedBox(height: 14),

            // Interval Semprot Berikutnya
            const Text(
              'Jadwal Semprot Ulang:',
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Row(
              children: [5, 7, 10, 14].map((days) {
                final isSelected = _intervalDays == days;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text('+ $days Hari'),
                    selected: isSelected,
                    selectedColor: const Color(0xFFC8E6C9),
                    onSelected: (val) {
                      if (val) setState(() => _intervalDays = days);
                    },
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 14),

            // Catatan Tambahan
            _buildTextField(
              controller: _noteController,
              label: 'Catatan Lapangan (Opsional)',
              hint: 'Kondisi cuaca, blok bedengan, dsb.',
            ),

            const SizedBox(height: 20),

            // Tombol Simpan
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _saveLog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B5E20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Simpan ke Jurnal Kebun',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(fontSize: 12.5, color: Color(0xFF9CA3AF)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

