
class Pesanan {
  final int? id;
  final String ringkasanItem;
  final int totalItem;
  final double totalHarga;
  final String tanggal;

  const Pesanan({
    this.id,
    required this.ringkasanItem,
    required this.totalItem,
    required this.totalHarga,
    required this.tanggal,
  });

  // Mengubah objek Pesanan menjadi Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ringkasan_item': ringkasanItem,
      'total_item': totalItem,
      'total_harga': totalHarga,
      'tanggal': tanggal,
    };
  }

  // Mengubah Map dari SQLite menjadi objek Pesanan
  factory Pesanan.fromMap(Map<String, dynamic> map) {
    return Pesanan(
      id: map['id'] as int?,
      ringkasanItem: map['ringkasan_item'] as String,
      totalItem: map['total_item'] as int,
      totalHarga: (map['total_harga'] as num).toDouble(),
      tanggal: map['tanggal'] as String,
    );
  }
}
