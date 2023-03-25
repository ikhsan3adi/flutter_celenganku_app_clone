import 'package:celenganku_app_clone/shared/shared.dart';
import 'package:equatable/equatable.dart';

class WishRepository extends Equatable {
  const WishRepository({required WishApi wishApi}) : _wishApi = wishApi;

  final WishApi _wishApi;

  List<Wish> getOnGoingWishList() {
    return _wishApi.getWishList().where((e) => e.completedAt == null).toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  List<Wish> getAchievedWishList() {
    return _wishApi.getWishList().where((e) => e.completedAt != null).toList()..sort((a, b) => b.completedAt!.compareTo(a.completedAt!));
  }

  Future<void> saveWish(Wish wish) async {
    await _wishApi.saveWish(wish);
  }

  Future<void> deleteWish(String id) async {
    await _wishApi.deleteWish(id);
  }

  Future<void> addSaving(String id, Saving saving) async {
    await _wishApi.addSaving(id, saving);
  }

  @override
  List<Object?> get props => [_wishApi];
}
