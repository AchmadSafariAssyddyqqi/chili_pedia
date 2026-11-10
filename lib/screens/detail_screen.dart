import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/pest_disease_model.dart';
import '../services/bookmark_service.dart';

class DetailScreen extends StatelessWidget {
  final PestDiseaseModel item;

  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final bool isPenyakit = item.category == CategoryType.penyakit;
    final themeColor = isPenyakit ? const Color(0xFF2E7D32) : const Color(0xFFE65100);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          // App Bar with Hero-like Header Banner
          SliverAppBar(
            expandedHeight: 280.0,
            pinned: true,
            backgroundColor: themeColor,
            elevation: 2,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              // Tombol Bookmark / Pantauan Kebun
              AnimatedBuilder(
                animation: BookmarkService(),
                builder: (context, _) {
                  final isBookmarked =
                      BookmarkService().isBookmarked(item.id);
                  return IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.black26,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isBookmarked
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: isBookmarked
                            ? const Color(0xFFFFF176)
                            : Colors.white,
                        size: 19,
                      ),
                    ),
                    tooltip: isBookmarked
                        ? 'Hapus dari Pantauan'
                        : 'Simpan ke Pantauan Kebun',
                    onPressed: () {
                      BookmarkService().toggleBookmark(item.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isBookmarked
                                ? '${item.name} dihapus dari daftar pantauan.'
                                : '⭐ ${item.name} berhasil disimpan ke pantauan kebun!',
                          ),
                          backgroundColor: themeColor,
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  );
                },
              ),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.copy, color: Colors.white, size: 18),
                ),
                tooltip: 'Salin Ringkasan Solusi',
                onPressed: () {
                  final text = 'Cara Pengendalian ${item.name}:\n\n${item.controlMethod}';
                  Clipboard.setData(ClipboardData(text: text));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Langkah pengendalian ${item.name} berhasil disalin!'),
                      backgroundColor: themeColor,
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Full Image Background
                  Hero(
                    tag: 'image_${item.id}',
                    child: Image.asset(
                      item.imageAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [themeColor, item.primaryColor],
                            ),
                          ),
                          child: Center(
                            child: Icon(item.icon, size: 120, color: Colors.white24),
                          ),
                        );
                      },
                    ),
                  ),

                  // Dark Gradient Overlay for optimal readability
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent,
                          Colors.black.withOpacity(0.85),
                        ],
                        stops: const [0.0, 0.4, 1.0],
                      ),
                    ),
                  ),

                  // Text Info at bottom of header
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Category Tag
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.4),
                              ),
                            ),
                            child: Text(
                              '${item.categoryLabel} • ${item.tag}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Nama Utama
                          Text(
                            item.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Alias / Nama Latin
                          Text(
                            item.alias,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Body Content (ScrollView / Cards)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tombol Zoom Foto (Pinch to zoom)
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => _showZoomDialog(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFBFDBFE)),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.zoom_in, color: Color(0xFF2563EB), size: 20),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Ketuk di sini untuk zoom & periksa foto secara detail',
                              style: TextStyle(
                                fontSize: 12.5,
                                color: Color(0xFF1E40AF),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Icon(Icons.chevron_right, color: Color(0xFF2563EB), size: 18),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  // 1. Bagian Yang Diserang Card
                  _buildInfoCard(
                    icon: Icons.track_changes,
                    iconColor: const Color(0xFFD97706),
                    iconBgColor: const Color(0xFFFEF3C7),
                    title: 'Bagian yang Diserang',
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item.attackedPart.toLowerCase().contains('buah')
                                ? Icons.apple_rounded
                                : Icons.eco,
                            color: const Color(0xFF059669),
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              item.attackedPart,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 2. Ciri-ciri & Gejala
                  _buildInfoCard(
                    icon: Icons.visibility_outlined,
                    iconColor: const Color(0xFFDC2626),
                    iconBgColor: const Color(0xFFFEE2E2),
                    title: 'Ciri-ciri & Gejala',
                    child: Text(
                      item.symptoms,
                      style: const TextStyle(
                        fontSize: 14.5,
                        color: Color(0xFF374151),
                        height: 1.55,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 3. Penyebab
                  _buildInfoCard(
                    icon: Icons.biotech_outlined,
                    iconColor: const Color(0xFF7C3AED),
                    iconBgColor: const Color(0xFFEDE9FE),
                    title: 'Penyebab',
                    child: Text(
                      item.cause,
                      style: const TextStyle(
                        fontSize: 14.5,
                        color: Color(0xFF374151),
                        height: 1.55,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 4. Cara Pengendalian (Solusi)
                  _buildInfoCard(
                    icon: Icons.health_and_safety_outlined,
                    iconColor: const Color(0xFF059669),
                    iconBgColor: const Color(0xFFD1FAE5),
                    title: 'Cara Pengendalian',
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0FDF4),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFBBF7D0)),
                      ),
                      child: Text(
                        item.controlMethod,
                        style: const TextStyle(
                          fontSize: 14.5,
                          color: Color(0xFF166534),
                          height: 1.6,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Bottom Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Informasi mengenai ${item.name} telah dipahami.',
                            ),
                            duration: const Duration(seconds: 2),
                            backgroundColor: themeColor,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
                      label: const Text(
                        'Tandai Telah Dibaca',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showZoomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(12),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            InteractiveViewer(
              panEnabled: true,
              minScale: 0.8,
              maxScale: 4.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(item.imageAsset),
              ),
            ),
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 20),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
