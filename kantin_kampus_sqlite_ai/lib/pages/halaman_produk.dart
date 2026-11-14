
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/produk.dart';
import '../cubit/keranjang_cubit.dart';
import '../widgets/product_card.dart';
import '../widgets/cart_summary_bar.dart';
import '../widgets/theme_toggle_button.dart';
import 'halaman_riwayat.dart';

class HalamanProduk extends StatelessWidget {
  final VoidCallback onLihatKeranjang;

  const HalamanProduk({
    super.key,
    required this.onLihatKeranjang,
  });

  static const List<Produk> daftarProduk = [
    Produk(
      id: 1,
      nama: 'Nasi Goreng',
      kategori: 'Makanan',
      harga: 15000,
      emoji: '🍛',
    ),
    Produk(
      id: 2,
      nama: 'Mie Goreng',
      kategori: 'Makanan',
      harga: 12000,
      emoji: '🍜',
    ),
    Produk(
      id: 3,
      nama: 'Ayam Geprek',
      kategori: 'Makanan',
      harga: 18000,
      emoji: '🍗',
    ),
    Produk(
      id: 4,
      nama: 'Roti Bakar',
      kategori: 'Snack',
      harga: 10000,
      emoji: '🍞',
    ),
    Produk(
      id: 5,
      nama: 'Es Teh',
      kategori: 'Minuman',
      harga: 5000,
      emoji: '🧋',
    ),
    Produk(
      id: 6,
      nama: 'Kopi Susu',
      kategori: 'Minuman',
      harga: 10000,
      emoji: '☕',
    ),
    Produk(
      id: 7,
      nama: 'Jus Jeruk',
      kategori: 'Minuman',
      harga: 8000,
      emoji: '🍊',
    ),
    Produk(
      id: 8,
      nama: 'Kentang Goreng',
      kategori: 'Snack',
      harga: 12000,
      emoji: '🍟',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kantin Kampus',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Pilih menu favoritmu',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        actions: const [
          ThemeToggleButton(),
          SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daftar Produk',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Temukan makanan dan minuman favoritmu.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: daftarProduk.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.68,
                ),
                itemBuilder: (context, index) {
                  final produk = daftarProduk[index];

                  return ProductCard(
                    produk: produk,
                    onTambah: () {
                      context.read<KeranjangCubit>().tambah(produk);

                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                              '${produk.nama} ditambahkan ke keranjang',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          BlocBuilder<KeranjangCubit, List<ItemKeranjang>>(
        builder: (context, keranjang) {
          final totalItem = keranjang.fold<int>(
            0,
            (total, item) => total + item.jumlah,
          );

          final totalHarga = keranjang.fold<int>(
            0,
            (total, item) => total + item.subtotal,
          );

          return CartSummaryBar(
            totalItem: totalItem,
            totalHarga: totalHarga,
            onLihatKeranjang: onLihatKeranjang,
          );
        },
      ),
    );
  }
}
