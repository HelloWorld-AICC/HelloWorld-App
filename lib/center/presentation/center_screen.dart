import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';

import '../../custom_bottom_navigationbar.dart';
import '../application/center_bloc.dart';

import '../domain/model/center.dart' as center_model;
import 'center_card.dart';

class CenterScreen extends StatefulWidget {
  CenterScreen({Key? key}) : super(key: key);

  @override
  State<CenterScreen> createState() => _CenterScreenState();

  static const List<BoxShadow> _boxShadow = [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];
}

class _CenterScreenState extends State<CenterScreen> {
  late LatLng _futurePosition;
  late double? latitude = null;
  late double? longitude = null;

  List<LatLng> _centerLocations = [];

  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    _initializeMapRenderer();
    _fetchPosition();
  }

  Future<void> _fetchPosition() async {
    try {
      final position = await _determinePosition();
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });

      context.read<CenterBloc>().add(GetCenter(longitude!, latitude!, 0, 5));
    } catch (e) {
      print('Error determining position: $e');
    }
  }

  void _initializeMapRenderer() {
    final GoogleMapsFlutterPlatform mapsImplementation =
        GoogleMapsFlutterPlatform.instance;
    if (mapsImplementation is GoogleMapsFlutterAndroid) {
      mapsImplementation.useAndroidViewSurface = true;
    }
  }

  Future<LatLng> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw Exception('Location services are disabled.');

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    Position position = await Geolocator.getCurrentPosition();
    latitude = position.latitude;
    longitude = position.longitude;
    print("geolocator에서 가져온 latitude: $latitude, longitude: $longitude");
    return LatLng(position.latitude, position.longitude);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(latitude ?? 37.3213, longitude ?? 127.1272),
        zoom: 11.0,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (_centerLocations.length != 0 && _centerLocations.length % 5 == 0) {
      context.read<CenterBloc>().add(
          GetCenter(longitude!, latitude!, _centerLocations.length ~/ 5, 5));
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: HelloColors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildMapContainer(context),
            _buildLocationText(context),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          items: bottomNavItems,
        ),
      ),
    );
  }

  Widget _buildLocationText(BuildContext context) {
    final centers = context.watch<CenterBloc>().state.centers;
    if (centers.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.005,
              decoration: const BoxDecoration(
                color: HelloColors.subTextColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(50),
                  right: Radius.circular(50),
                ),
                boxShadow: CenterScreen._boxShadow,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: Container(
              child: CircularProgressIndicator(color: HelloColors.mainBlue),
              alignment: Alignment.center,
            ))
          ],
        ),
      );
    }

    return Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
                child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.005,
              decoration: const BoxDecoration(
                color: HelloColors.subTextColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(50),
                  right: Radius.circular(50),
                ),
                // boxShadow: CenterScreen._boxShadow,
              ),
            )),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: centers.map(
                  (myCenter) {
                    _centerLocations.add(LatLng(myCenter.latitude.getOrCrash(),
                        myCenter.longitude.getOrCrash()));
                    print("added centerLocations: $_centerLocations");

                    return CenterCard(
                      center: myCenter,
                    );
                  },
                ).toList(),
              ),
            )
          ],
        ));
  }

  Widget _buildMapContainer(BuildContext context) {
    if (latitude == null || longitude == null) {
      return Expanded(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(color: HelloColors.mainBlue),
        ),
      );
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: _buildMapWithOverlay(
          context, LatLng(latitude ?? 37.3213, longitude ?? 127.1272)),
    );
  }

  Widget _buildMapWithOverlay(BuildContext context, LatLng currentLocation) {
    return Stack(
      children: [
        _buildGoogleMap(currentLocation),
        _buildOverlay(context),
      ],
    );
  }

  Widget _buildGoogleMap(LatLng currentLocation) {
    print("centers: $_centerLocations");

    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: currentLocation,
        zoom: 11.0,
      ),
      markers: {
        // Red marker for the current location
        Marker(
          markerId: MarkerId('current_location'),
          position: currentLocation,
          infoWindow: const InfoWindow(title: "Your Location"),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed), // Red marker
        ),
        // Blue markers for the center locations
        ..._centerLocations.map(
          (latLng) => Marker(
            markerId: MarkerId('center_${_centerLocations.indexOf(latLng)}'),
            position: latLng,
            infoWindow: InfoWindow(title: "Center Location"),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue), // Blue marker
          ),
        ),
      },
    );
  }

  Widget _buildOverlay(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.05,
      left: MediaQuery.of(context).size.width * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildBackButton(context),
          SizedBox(width: MediaQuery.of(context).size.width * 0.1),
          _buildLocationInfo(),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: CenterScreen._boxShadow,
          ),
          child: Image(
            image: const AssetImage('assets/icons/vector.png'),
          )
          // child: Icon(
          //   Icons.arrow_back_ios_new_rounded,
          //   color: HelloColors.subTextColor,
          // ),
          ),
    );
  }

  Widget _buildLocationInfo() {
    return Container(
      width: 160,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(50),
          right: Radius.circular(50),
        ),
        boxShadow: CenterScreen._boxShadow,
      ),
      child: const Padding(
        padding: EdgeInsets.all(4.0),
        child: Text(
          '오프라인 상담센터',
          style: TextStyle(
            fontFamily: 'SB AggroOTF',
            color: HelloColors.subTextColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
