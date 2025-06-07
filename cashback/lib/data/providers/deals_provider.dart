import 'package:flutter/foundation.dart';
import '../../core/models/merchant_model.dart';
import '../../core/models/offer_model.dart';
import '../../data/repositories/cashback_repository.dart';

class DealsProvider with ChangeNotifier {
  final CashbackRepository _repository;
  List<MerchantModel> _featuredMerchants = [];
  List<OfferModel> _activeOffers = [];
  bool _isLoading = false;
  String? _error;

  DealsProvider(this._repository);

  List<MerchantModel> get featuredMerchants => _featuredMerchants;
  List<OfferModel> get activeOffers => _activeOffers;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadInitialData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _featuredMerchants = await _repository.getFeaturedMerchants();
      _activeOffers = await _repository.getActiveOffers();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<MerchantModel>> getNearbyMerchants(double lat, double lng) async {
    try {
      return await _repository.getNearbyMerchants(lat, lng);
    } catch (e) {
      _error = e.toString();
      return [];
    }
  }

  Future<List<OfferModel>> getMerchantOffers(String merchantId) async {
    try {
      return await _repository.getMerchantOffers(merchantId);
    } catch (e) {
      _error = e.toString();
      return [];
    }
  }
}
