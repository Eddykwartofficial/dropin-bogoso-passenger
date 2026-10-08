import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DropInHome extends StatefulWidget {
  @override _DropInHomeState createState() => _DropInHomeState();
}

class _DropInHomeState extends State<DropInHome> {
  String selectedRide = "Okada";

  final Map<String, double> prices = {
    "Okada": 12.50,
    "Keke": 18.00,
    "Economy Car": 35.00,
    "Shared Ride": 10.00,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(5.308, -1.988), // Tarkwa
              zoom: 12,
            ),
            markers: {
              Marker(markerId: MarkerId("tarkwa"), position: LatLng(5.308, -1.988), infoWindow: InfoWindow(title: "Tarkwa - Pickup")),
              Marker(markerId: MarkerId("bogoso"), position: LatLng(5.557, -2.004), infoWindow: InfoWindow(title: "Bogoso - Destination")),
            },
            polylines: {
              Polyline(polylineId: PolylineId("route"), points: [LatLng(5.308, -1.988), LatLng(5.557, -2.004)], color: Colors.teal, width: 5)
            },
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.45,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
                padding: EdgeInsets.all(16),
                child: ListView(
                  controller: scrollController,
                  children: [
                    Text("Choose your ride", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 12),
                    _rideTile("Okada", "Motorbike • Fastest for rural roads", "GH₵ 12.50", Icons.motorcycle),
                    _rideTile("Keke", "Tricycle • Seats 3 • Budget", "GH₵ 18.00", Icons.electric_rickshaw),
                    _rideTile("Economy Car", "Car • 4 seats • AC", "GH₵ 35.00", Icons.directions_car),
                    _rideTile("Shared Ride", "Share • Up to 3 riders • Lowest", "GH₵ 10.00", Icons.people),
                    SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0D8A72), minimumSize: Size(double.infinity, 56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))),
                      onPressed: () {},
                      child: Text("Confirm Ride • GH₵ ${prices[selectedRide]}", style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                    Center(child: Padding(padding: EdgeInsets.only(top: 8), child: Text("Payment: Cash • MoMo • Rural area estimate", style: TextStyle(fontSize: 11))))
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _rideTile(String name, String desc, String price, IconData icon) {
    bool isSelected = selectedRide == name;
    return GestureDetector(
      onTap: () => setState(() => selectedRide = name),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(color: isSelected? Color(0xFFD6F0EB) : Colors.white, border: Border.all(color: isSelected? Color(0xFF0D8A72) : Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
        child: Row(children: [
          Icon(icon, color: Color(0xFF0D8A72)),
          SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold)), Text(desc, style: TextStyle(fontSize: 12))])),
          Text(price, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ]),
      ),
    );
  }
}
