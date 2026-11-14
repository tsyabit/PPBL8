
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/produk.dart';

class KeranjangCubit extends Cubit<List<ItemKeranjang>> {
  KeranjangCubit() : super([]);

  void tambah(Produk produk) {
    final index = state.indexWhere(
      (item) => item.produk.id == produk.id,
    );

    if (index == -1) {
      emit([
        ...state,
        ItemKeranjang(produk: produk, jumlah: 1),
      ]);
    } else {
      final keranjangBaru = List<ItemKeranjang>.from(state);

      keranjangBaru[index] = keranjangBaru[index].copyWith(
        jumlah: keranjangBaru[index].jumlah + 1,
      );

      emit(keranjangBaru);
    }
  }

  void kurangi(Produk produk) {
    final index = state.indexWhere(
      (item) => item.produk.id == produk.id,
    );

    if (index == -1) return;

    final keranjangBaru = List<ItemKeranjang>.from(state);
    final item = keranjangBaru[index];

    if (item.jumlah > 1) {
      keranjangBaru[index] = item.copyWith(
        jumlah: item.jumlah - 1,
      );
    } else {
      keranjangBaru.removeAt(index);
    }

    emit(keranjangBaru);
  }

  void kosongkan() {
    emit([]);
  }

  int get totalItem => state.fold(
    0,
    (total, item) => total + item.jumlah,
  );

  int get totalHarga => state.fold(
    0,
    (total, item) => total + item.subtotal,
  );
}
