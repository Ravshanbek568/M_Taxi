// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// enum TaksiTuri { mahalliy, shaxarlararo, yukTashish }

// class TaxiOrderScreen extends StatefulWidget {
//   final TaksiTuri taksiTuri;
//   final LatLng boshlangichLokatsiya;
  
//   const TaxiOrderScreen({
//     super.key,
//     required this.taksiTuri,
//     required this.boshlangichLokatsiya,
//   });

//   @override
//   State<TaxiOrderScreen> createState() => _TaxiOrderScreenState();
// }

// class _TaxiOrderScreenState extends State<TaxiOrderScreen> {
//   late GoogleMapController _mapController;
//   final Set<Marker> _markers = {};
//   final Set<Polyline> _polylines = {};

//   @override
//   void initState() {
//     super.initState();
//     _loadTaksiTurlarigaQarabMaplumot();
//   }

//   void _loadTaksiTurlarigaQarabMaplumot() {
//     switch (widget.taksiTuri) {
//       case TaksiTuri.mahalliy:
//         _loadMahalliyTaksilar();
//         break;
//       case TaksiTuri.shaxarlararo:
//         _loadShaxarlararoTaksilar();
//         break;
//       case TaksiTuri.yukTashish:
//         _loadYukTashishTaksilar();
//         break;
//     }
//   }

//   void _loadMahalliyTaksilar() {
//     // Mahalliy taksilarni yuklash logikasi
//     setState(() {
//       _markers.add(
//         Marker(
//           markerId: const MarkerId('current_location'),
//           position: widget.boshlangichLokatsiya,
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//           infoWindow: const InfoWindow(title: 'Sizning joylashuvingiz'),
//         ),
//       );
      
//       // Qo'shimcha mahalliy taksilar (API dan olish kerak)
//       _markers.addAll(_getMockMahalliyTaksilar());
//     });
//   }

//   void _loadShaxarlararoTaksilar() {
//     // Shaharlararo taksilar logikasi
//     setState(() {
//       _polylines.add(
//         Polyline(
//           polylineId: const PolylineId('intercity_route'),
//           points: _getMockShaxarlararoYoanalish(),
//           color: Colors.blue,
//           width: 4,
//         ),
//       );
//     });
//   }

//   void _loadYukTashishTaksilar() {
//     // Yuk tashish taksilari logikasi
//     setState(() {
//       _markers.addAll(_getMockYukTashishTaksilar());
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_getScreenTitle()),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: GoogleMap(
//               onMapCreated: (controller) => _mapController = controller,
//               initialCameraPosition: CameraPosition(
//                 target: widget.boshlangichLokatsiya,
//                 zoom: _getInitialZoom(),
//               ),
//               markers: _markers,
//               polylines: _polylines,
//             ),
//           ),
//           _buildBottomSheet(),
//         ],
//       ),
//     );
//   }

//   String _getScreenTitle() {
//     switch (widget.taksiTuri) {
//       case TaksiTuri.mahalliy:
//         return 'Mahalliy Taksi';
//       case TaksiTuri.shaxarlararo:
//         return 'Shaharlararo Taksi';
//       case TaksiTuri.yukTashish:
//         return 'Yuk Tashish Xizmati';
//     }
//   }

//   double _getInitialZoom() {
//     switch (widget.taksiTuri) {
//       case TaksiTuri.mahalliy:
//         return 14;
//       case TaksiTuri.shaxarlararo:
//         return 9;
//       case TaksiTuri.yukTashish:
//         return 12;
//     }
//   }

//   Widget _buildBottomSheet() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _buildVehicleTypeSelector(),
//           const SizedBox(height: 16),
//           _buildPriceInfo(),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: _confirmOrder,
//             child: const Text('BUYURTMA QILISH'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildVehicleTypeSelector() {
//     List<Vehicle> vehicles = [];
    
//     switch (widget.taksiTuri) {
//       case TaksiTuri.mahalliy:
//         vehicles = _getMahalliyVehicleTypes();
//         break;
//       case TaksiTuri.shaxarlararo:
//         vehicles = _getShaxarlararoVehicleTypes();
//         break;
//       case TaksiTuri.yukTashish:
//         vehicles = _getYukTashishVehicleTypes();
//         break;
//     }

//     return SizedBox(
//       height: 100,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: vehicles.length,
//         itemBuilder: (context, index) {
//           return _buildVehicleCard(vehicles[index]);
//         },
//       ),
//     );
//   }

//   Widget _buildPriceInfo() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           'Taxminiy narx:',
//           style: Theme.of(context).textTheme.titleMedium,
//         ),
//         Text(
//           _calculatePrice(),
//           style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                 fontWeight: FontWeight.bold,
//                 color: Theme.of(context).primaryColor,
//               ),
//         ),
//       ],
//     );
//   }

//   // Mock ma'lumotlar (aslida API dan olinadi)
//   Set<Marker> _getMockMahalliyTaksilar() {
//     return {
//       Marker(
//         markerId: const MarkerId('taksi_1'),
//         position: LatLng(
//           widget.boshlangichLokatsiya.latitude + 0.005,
//           widget.boshlangichLokatsiya.longitude + 0.005,
//         ),
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//         infoWindow: const InfoWindow(title: 'Taksi #1'),
//       ),
//       // Boshqa taksilar...
//     };
//   }

//   // Qolgan mock metodlar...
// }

// class Vehicle {
//   final String name;
//   final String icon;
//   final String price;

//   Vehicle(this.name, this.icon, this.price);
// }