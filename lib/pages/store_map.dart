import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopping/config/http.dart';
import 'package:smart_shopping/state/user.dart';

class StoreMap extends StatefulWidget {
  @override
  _StoreMapState createState() => _StoreMapState();
}

class _StoreMapState extends State<StoreMap> {
  Completer<GoogleMapController> _mapControllerCompleter = Completer();
  GoogleMapController _mapController;
  Map<MarkerId, Marker> storeMarkers = <MarkerId, Marker>{};
  LocationData currentLocation;
  User _user;

  @override
  void initState() {
    super.initState();
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(45.8157007, 23.9905338),
    zoom: 7,
  );

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Harta magazinelor'),
        centerTitle: true,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
          _mapControllerCompleter.complete(controller);
          _goToMyLocation(controller);
        },
        markers: Set<Marker>.of(storeMarkers.values),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getStoresInMyArea,
        child: Icon(Icons.store),
      ),
    );
  }

  Future<void> _goToMyLocation(GoogleMapController controller) async {
    await _getCurrentLocation();

    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 17,
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
        ),
      ),
    );
  }

  void _zoomOut() {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 14,
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
        ),
      ),
    );
  }

  Future<void> _getStoresInMyArea() async {
    int range = 2000; // meters

    try {
      List<String> productCategories = [];

      _user.shoppingList.forEach((item) {
        productCategories.add(item.id);
      });

      final response = (await http.get(
              'find?lat=${currentLocation.latitude}&lon=${currentLocation.longitude}&buffer=$range&csvprodids=${productCategories.join(',')}'))
          .data;
      response['Items'].forEach((item) async {
        final List productList = item['Products'];
        productList.retainWhere((item) =>
            productCategories.contains(item['catprod']['id']) &&
            item['id'] != null);

        if (productList.isNotEmpty) {
          final MarkerId markerId = MarkerId(item['id']);

          final logoResponse = await http.get(item['logo']['logouri'],
              options: Options(responseType: ResponseType.bytes));

          final Marker marker = Marker(
            markerId: markerId,
            position: LatLng(
              item['addr']['location']['Lat'],
              item['addr']['location']['Lon'],
            ),
            icon: BitmapDescriptor.fromBytes(
                Uint8List.fromList(logoResponse.data)),
            infoWindow: InfoWindow(
              title: '${item['name']} (${productList.length})',
              snippet: '${item['addr']['addrstring']}',
            ),
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) => Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height / 3,
                ),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate(
                        List.generate(
                          _user.shoppingList.length,
                          (index) {
                            final _isItemInShop = productList.firstWhere(
                                (_item) =>
                                    _item['catprod']['id'] ==
                                    _user.shoppingList[index].id,
                                orElse: () => null);

                            return ListTile(
                              leading: Icon(
                                _isItemInShop != null
                                    ? Icons.check_box
                                    : Icons.cancel,
                                color: _isItemInShop != null
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              title: Text('${_user.shoppingList[index].name}'),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );

          setState(() {
            storeMarkers[markerId] = marker;
          });

          _zoomOut();
        }
      });
    } catch (error) {
      print(error);
    }
  }

  _getCurrentLocation() async {
    Location location = new Location();

    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
      currentLocation = null;
    }
  }
}
