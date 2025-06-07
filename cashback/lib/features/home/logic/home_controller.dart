import 'package:flutter/foundation.dart';
import '../../../../core/models/merchant_model.dart';
import '../../../../core/models/offer_model.dart';
import '../../../../data/repositories/cashback_repository.dart';

class HomeController with ChangeNotifier {
  final CashbackRepository _repository;
  List<MerchantModel> _featuredMerchants = [];
  List<OfferModel> _activeOffers = [];
  bool _isLoading = false;
  String? _error;

  HomeController(this._repository);

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
}
