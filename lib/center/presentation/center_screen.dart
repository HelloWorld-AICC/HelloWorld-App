import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';

import '../../custom_bottom_navigationbar.dart';
import '../../injection.dart';
import '../application/center_bloc.dart';

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
  late double latitude;
  late double longitude;

  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    _initializeMapRenderer();
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
    return LatLng(position.latitude, position.longitude);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CenterBloc>(),
      child: SafeArea(
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
      ),
    );
  }

  Widget _buildLocationText(BuildContext context) {
    return FutureBuilder<LatLng>(
      future: _determinePosition(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          print('latitude: $latitude, longitude: $longitude');

          context.read<CenterBloc>().add(
                GetCenter(longitude, latitude, 0, 10),
              );

          final centers = context.watch<CenterBloc>().state.centers;
          if (centers.isEmpty) {
            return const Center(child: Text('No centers found'));
          }

          return Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  children: centers
                      .map(
                        (center) => ListTile(
                          title: Text(center.name.getOrCrash()),
                          subtitle: Text(center.address.getOrCrash()),
                        ),
                      )
                      .toList()));
        } else {
          return const Center(child: Text('Unable to get location'));
        }
      },
    );
  }

  Widget _buildMapContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: FutureBuilder<LatLng>(
        future: _determinePosition(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return _buildMapWithOverlay(context, snapshot.data!);
          } else {
            return const Center(child: Text('Unable to get location'));
          }
        },
      ),
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
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: currentLocation,
        zoom: 11.0,
      ),
      markers: {
        Marker(
          markerId: MarkerId('current_location'),
          position: currentLocation,
          infoWindow: const InfoWindow(title: "Your Location"),
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
          SizedBox(width: MediaQuery.of(context).size.width * 0.2),
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
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: HelloColors.subTextColor,
        ),
      ),
    );
  }

  Widget _buildLocationInfo() {
    return Container(
      width: 150,
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
