
class Produk {
  final int id;
  final String nama;
  final String kategori;
  final int harga;
  final String emoji;

  const Produk({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.emoji,
  });
}

class ItemKeranjang {
  final Produk produk;
  final int jumlah;

  const ItemKeranjang({
    required this.produk,
    required this.jumlah,
  });

  int get subtotal => produk.harga * jumlah;

  ItemKeranjang copyWith({
    Produk? produk,
    int? jumlah,
  }) {
    return ItemKeranjang(
      produk: produk ?? this.produk,
      jumlah: jumlah ?? this.jumlah,
    );
  }
}
