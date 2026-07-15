import 'package:flutter/material.dart';

class LemburPage extends StatefulWidget {
  const LemburPage({super.key});

  @override
  State<LemburPage> createState() => _LemburPageState();
}

class _LemburPageState extends State<LemburPage> {
  static const Color kPrimary =
  Color.fromARGB(255, 135, 89, 164);

  static const Color kSurface =
  Color(0xFFF7F8FA);

  static const double kRadius = 16;

  final List<Map<String, dynamic>> lemburList = [
    {
      'tanggal': '31 Mei 2026',
      'jam': '18:00 - 21:00',
      'deskripsi': 'Maintenance server kantor',
      'status': 'Approved',
    },
    {
      'tanggal': '30 Mei 2026',
      'jam': '19:00 - 22:00',
      'deskripsi': 'Deploy update aplikasi',
      'status': 'Pending',
    },
    {
      'tanggal': '28 Mei 2026',
      'jam': '17:30 - 20:00',
      'deskripsi': 'Perbaikan bug absensi',
      'status': 'Rejected',
    },
  ];

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;

      case 'pending':
        return Colors.orange;

      case 'rejected':
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  IconData _statusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Icons.check_circle_rounded;

      case 'pending':
        return Icons.schedule_rounded;

      case 'rejected':
        return Icons.cancel_rounded;

      default:
        return Icons.info_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: kSurface,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,

        title: const Text(
          'Lembur',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),

          children: [
            // ======================
            // HEADER CARD
            // ======================

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    kPrimary,
                    Color(0xFF9E6CC8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),

                borderRadius:
                BorderRadius.circular(kRadius),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: 0.08,
                    ),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,

                        decoration: BoxDecoration(
                          color: Colors.white
                              .withValues(
                            alpha: 0.15,
                          ),

                          borderRadius:
                          BorderRadius.circular(
                            14,
                          ),
                        ),

                        child: const Icon(
                          Icons.schedule_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                          children: [
                            Text(
                              'Pengajuan Lembur',
                              style: theme
                                  .textTheme.titleLarge
                                  ?.copyWith(
                                color:
                                Colors.white,
                                fontWeight:
                                FontWeight
                                    .w700,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              'Ajukan dan lihat riwayat lembur Anda',
                              style: theme
                                  .textTheme.bodySmall
                                  ?.copyWith(
                                color:
                                Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  Row(
                    children: [
                      Expanded(
                        child: _summaryCard(
                          title: 'Total',
                          value: '24 Jam',
                          icon:
                          Icons.timer_rounded,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: _summaryCard(
                          title: 'Pending',
                          value: '2',
                          icon:
                          Icons.pending_actions_rounded,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ======================
            // TITLE
            // ======================

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  'Riwayat Lembur',
                  style: theme
                      .textTheme.titleMedium
                      ?.copyWith(
                    fontWeight:
                    FontWeight.w700,
                  ),
                ),

                TextButton.icon(
                  onPressed: () {},

                  icon: const Icon(
                    Icons.filter_alt_rounded,
                    size: 18,
                  ),

                  label: const Text('Filter'),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // ======================
            // LIST LEMBUR
            // ======================

            if (lemburList.isEmpty)
              _emptyState()
            else
              ...lemburList.map(
                    (item) => _lemburCard(item),
              ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      // ======================
      // FLOATING BUTTON
      // ======================

      floatingActionButton:
      FloatingActionButton.extended(
        backgroundColor: kPrimary,

        onPressed: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            const SnackBar(
              content: Text(
                'Form lembur segera dibuat',
              ),
            ),
          );
        },

        icon: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),

        label: const Text(
          'Ajukan Lembur',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ======================
  // SUMMARY CARD
  // ======================

  Widget _summaryCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white.withValues(
          alpha: 0.12,
        ),

        borderRadius:
        BorderRadius.circular(14),
      ),

      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,

            decoration: BoxDecoration(
              color: Colors.white.withValues(
                alpha: 0.16,
              ),

              borderRadius:
              BorderRadius.circular(12),
            ),

            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight:
                    FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ======================
  // CARD LEMBUR
  // ======================

  Widget _lemburCard(
      Map<String, dynamic> item,
      ) {
    final status = item['status'];

    return Container(
      margin: const EdgeInsets.only(
        bottom: 14,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(kRadius),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.05,
            ),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,

                  decoration: BoxDecoration(
                    color: kPrimary.withValues(
                      alpha: 0.1,
                    ),

                    borderRadius:
                    BorderRadius.circular(
                      14,
                    ),
                  ),

                  child: const Icon(
                    Icons.schedule_rounded,
                    color: kPrimary,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                    children: [
                      Text(
                        item['tanggal'],
                        style: const TextStyle(
                          fontWeight:
                          FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        item['jam'],
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),

                  decoration: BoxDecoration(
                    color: _statusColor(
                      status,
                    ).withValues(
                      alpha: 0.12,
                    ),

                    borderRadius:
                    BorderRadius.circular(
                      50,
                    ),
                  ),

                  child: Row(
                    mainAxisSize:
                    MainAxisSize.min,

                    children: [
                      Icon(
                        _statusIcon(status),
                        size: 16,
                        color: _statusColor(
                          status,
                        ),
                      ),

                      const SizedBox(width: 5),

                      Text(
                        status,
                        style: TextStyle(
                          color: _statusColor(
                            status,
                          ),
                          fontWeight:
                          FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(
                12,
              ),

              decoration: BoxDecoration(
                color: Colors.grey
                    .withValues(alpha: 0.05),

                borderRadius:
                BorderRadius.circular(
                  12,
                ),
              ),

              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  Icon(
                    Icons.notes_rounded,
                    size: 18,
                    color: Colors.grey[700],
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      item['deskripsi'],
                      style: TextStyle(
                        color: Colors.grey[800],
                        height: 1.5,
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

  // ======================
  // EMPTY STATE
  // ======================

  Widget _emptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 50,
      ),

      child: Column(
        children: [
          Icon(
            Icons.work_history_rounded,
            size: 70,
            color: Colors.grey[400],
          ),

          const SizedBox(height: 16),

          Text(
            'Belum ada data lembur',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.grey[700],
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Pengajuan lembur akan muncul di sini',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}