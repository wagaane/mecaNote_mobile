
import 'package:flutter/material.dart';
import 'package:meca_note_mobile/utils/notification_helper.dart';
import '../back-office/mecanicien/garages/list_garage_screen.dart';
import '../models/garage_response.dart'; // adjust import path
import '../services/garage_provider.dart';

class GarageProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 0;
  final int _size = 10;
  int _totalGarages = 0;
  List<GarageResponse> _garages = [];

  List<GarageResponse> get garages => _garages;
  bool get hasMore => _hasMore;
  int get totalGarages => _totalGarages;
  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void reset() {
    _garages.clear();
    _page = 0;
    _totalGarages = 0;
    _hasMore = true;
    notifyListeners();
  }
  Future<void> fetchNextPage() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
    var data = await GarageService.listGarages(page: _page, size: _size);
      _totalGarages = data['metadata']['totalElements'];
      List<GarageResponse> newGarages = GarageResponse.jsonList(data['payload']);

      if (newGarages.length < _size) {
        _hasMore = false;
      }

      _garages.addAll(newGarages);
      _page++;

    } catch (e) {
      print('Error fetching garages: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> listGarages() async {
    setLoading(true);
    try {
      final data = await GarageService.listGarages();
      _garages = GarageResponse.jsonList(data['payload']);
      notifyListeners();
    } catch (e) {
      print('Error fetching garages: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<bool> createGarage(garage,file, context) async {
    setLoading(true);
    try {
      var res = await GarageService.saveGarage(garage);
      if(res['status'] == 'OK'){
        NotificationHelper.success(context, res['message']);
        var createdGarage = GarageResponse.fromJson(res['payload']);
        if (file != null) {
          print('Fichier est chargé.');
          await GarageService.uploadImage(
              file!, createdGarage.id, 'profile');
        }
        _garages.clear();
        print('hello');
        var data = await GarageService.listGarages(page: 0, size: 10);
        print('$data');
        _garages = GarageResponse.jsonList( data['payload']);
        print('hello');
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const ListGarageScreen(),
          ),
        );
      }else{
        NotificationHelper.error(context, res['message']);
        return false;
      }

      notifyListeners();
      setLoading(false);
      return true;
    } catch (e) {
      print('Erreur lors de la création du garage: $e');
      setLoading(false);
      return false; // en cas d’échec
    } finally {
      setLoading(false);
    }
  }
}