import 'package:flutter/material.dart';

class DosageCalculatorScreen extends StatefulWidget {
  const DosageCalculatorScreen({super.key});

  @override
  State<DosageCalculatorScreen> createState() => _DosageCalculatorScreenState();
}

class _DosageCalculatorScreenState extends State<DosageCalculatorScreen> {
  final TextEditingController _tankVolumeController =
      TextEditingController(text: '16'); // Default tangki punggung 16 liter
  final TextEditingController _dosageController =
      TextEditingController(text: '2.0'); // Default 2 gram/ml per liter
  final TextEditingController _areaController =
      TextEditingController(text: '1000'); // Luas lahan m2

  String _pesticideType = 'Bubuk (Gram)';
  double _totalPerTank = 32.0;
  double _estimatedTanks = 3.0;

  @override
  void initState() {
    super.initState();
    _calculateDosage();
  }

  void _calculateDosage() {
    final double tankVolume =
        double.tryParse(_tankVolumeController.text.replaceAll(',', '.')) ?? 0;
    final double dosagePerLiter =
        double.tryParse(_dosageController.text.replaceAll(',', '.')) ?? 0;
    final double areaM2 =
        double.tryParse(_areaController.text.replaceAll(',', '.')) ?? 0;

    setState(() {
      _totalPerTank = tankVolume * dosagePerLiter;
      // Estimasi kebutuhan air semprot: rata-rata 400-500 Liter air per hektar (10.000 m2)
      // Jadi per 1.000 m2 butuh ~45 liter air (~3 tangki 16L)
      final double totalWaterNeeded = (areaM2 / 10000.0) * 450.0;
      _estimatedTanks =
          tankVolume > 0 ? (totalWaterNeeded / tankVolume).ceilToDouble() : 0;
      if (_estimatedTanks < 1 && areaM2 > 0) _estimatedTanks = 1;
    });
  }

  @override
  void dispose() {
    _tankVolumeController.dispose();
    _dosageController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPowder = _pesticideType.contains('Gram');
    final unit = isPowder ? 'Gram' : 'ml';

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text(
          'Kalkulator Dosis Semprot',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Intro Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFA5D6A7)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xFF2E7D32),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.calculate_outlined,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Text(
                      'Hitung takaran pestisida / fungisida tepat dosis untuk tangki semprot kebun cabai Anda.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF1B5E20),
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Input Fields
            Container(
              padding: const EdgeInsets.all(18),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Parameter Pencampuran',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const Divider(height: 24),

                  // Jenis Formulasi
                  const Text(
                    'Bentuk Formulasi Pestisida:',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF374151),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildTypeRadio('Bubuk (Gram)'),
                      const SizedBox(width: 12),
                      _buildTypeRadio('Cair (ml / cc)'),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Volume Tangki
                  _buildInputField(
                    controller: _tankVolumeController,
                    label: 'Kapasitas Tangki Semprot',
                    suffixText: 'Liter',
                    hintText: 'Misal 14 atau 16',
                    icon: Icons.water_drop_outlined,
                    onChanged: (val) => _calculateDosage(),
                  ),

                  const SizedBox(height: 14),

                  // Dosis Anjuran Kemasan
                  _buildInputField(
                    controller: _dosageController,
                    label: 'Dosis Anjuran pada Label Kemasan',
                    suffixText: '$unit / Liter air',
                    hintText: 'Misal 1.5 atau 2.0',
                    icon: Icons.science_outlined,
                    onChanged: (val) => _calculateDosage(),
                  ),

                  const SizedBox(height: 14),

                  // Luas Lahan
                  _buildInputField(
                    controller: _areaController,
                    label: 'Luas Lahan Cabai',
                    suffixText: 'm²',
                    hintText: 'Misal 1000 atau 2000',
                    icon: Icons.crop_free_outlined,
                    onChanged: (val) => _calculateDosage(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Output Hasil Perhitungan
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1B5E20),
                    Color(0xFF2E7D32),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1B5E20).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Color(0xFFFFF176),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Hasil Takaran Dosis:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Takaran Per 1 Tangki Semprot:',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              _totalPerTank.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '$unit / tangki',
                              style: const TextStyle(
                                color: Color(0xFFFFF176),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        if (isPowder) ...[
                          const SizedBox(height: 4),
                          Text(
                            '≈ ${(_totalPerTank / 12.0).toStringAsFixed(1)} sendok makan per tangki (asumsi 1 sdm = 12 gram)',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Estimasi Kebutuhan:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          '± ${_estimatedTanks.toInt()} Tangki Semprot',
                          style: const TextStyle(
                            color: Color(0xFFFFF176),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Catatan Keamanan
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBEB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFDE68A)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Color(0xFFD97706),
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Peringatan Keselamatan: Selalu gunakan masker, sarung tangan karet, dan semprotkan pada pagi hari (sebelum jam 09.00) atau sore hari saat angin tenang.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF92400E),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeRadio(String label) {
    final bool isSelected = _pesticideType == label;
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          setState(() {
            _pesticideType = label;
            _calculateDosage();
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFE8F5E9) : const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFFE5E7EB),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                size: 16,
                color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFF9CA3AF),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? const Color(0xFF1B5E20) : const Color(0xFF4B5563),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String suffixText,
    required String hintText,
    required IconData icon,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4B5563),
          ),
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
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: onChanged,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: const Color(0xFF2E7D32), size: 18),
              suffixText: suffixText,
              suffixStyle: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B7280),
              ),
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 12.5, color: Color(0xFF9CA3AF)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

