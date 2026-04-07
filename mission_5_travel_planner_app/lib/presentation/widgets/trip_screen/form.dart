import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/models/trip_model.dart';

class TripForm extends StatefulWidget {
  final TripModel? initialData;
  final Function(TripModel) onSubmit;
  final String submitLabel;

  const TripForm({
    super.key,
    this.initialData,
    required this.onSubmit,
    required this.submitLabel,
  });

  @override
  State<TripForm> createState() => _TripFormState();
}

class _TripFormState extends State<TripForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _latController;
  late TextEditingController _lngController;

  DateTime? _startDate;
  String _status = 'upcoming';

  LatLng? _selectedLatLng;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(
      text: widget.initialData?.title ?? '',
    );

    _latController = TextEditingController(
      text: widget.initialData?.lat.toString() ?? '',
    );

    _lngController = TextEditingController(
      text: widget.initialData?.long.toString() ?? '',
    );

    _startDate = widget.initialData?.startDate;
    _status = widget.initialData?.status ?? 'upcoming';

    if (widget.initialData != null) {
      _selectedLatLng = LatLng(
        widget.initialData!.lat,
        widget.initialData!.long,
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }

  // ================= PICK DATE =================
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  // ================= HANDLE MAP TAP =================
  void _onMapTapped(LatLng position) {
    setState(() {
      _selectedLatLng = position;
      _latController.text = position.latitude.toString();
      _lngController.text = position.longitude.toString();
    });
  }

  // ================= SUBMIT =================
  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;

    if (_startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih tanggal dulu')),
      );
      return;
    }

    if (_latController.text.isEmpty || _lngController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih lokasi di map')),
      );
      return;
    }

    final trip = TripModel(
      id: widget.initialData?.id ?? '',
      title: _titleController.text.trim(),
      startDate: _startDate!,
      endDate: _startDate!,
      status: _status,
      createdAt: widget.initialData?.createdAt ?? DateTime.now(),
      lat: double.parse(_latController.text),
      long: double.parse(_lngController.text),
    );

    widget.onSubmit(trip);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // ===== TITLE =====
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Trip Title',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title wajib diisi';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // ===== DATE =====
            Row(
              children: [
                Expanded(
                  child: Text(
                    _startDate == null
                        ? 'Pilih tanggal'
                        : _startDate.toString().split(' ')[0],
                  ),
                ),
                ElevatedButton(
                  onPressed: _pickDate,
                  child: const Text('Pick Date'),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ===== STATUS =====
            DropdownButtonFormField<String>(
              initialValue: _status,
              items: const [
                DropdownMenuItem(value: 'upcoming', child: Text('Upcoming')),
                DropdownMenuItem(value: 'ongoing', child: Text('Ongoing')),
                DropdownMenuItem(value: 'completed', child: Text('Completed')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _status = value;
                  });
                }
              },
              decoration: const InputDecoration(
                labelText: 'Status',
              ),
            ),

            const SizedBox(height: 16),

            // ===== GOOGLE MAP =====
            SizedBox(
              height: 250,
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(-6.2, 106.8),
                  zoom: 10,
                ),
                onTap: _onMapTapped,
                markers: _selectedLatLng == null
                    ? {}
                    : {
                        Marker(
                          markerId: const MarkerId('selected'),
                          position: _selectedLatLng!,
                        ),
                      },
              ),
            ),

            const SizedBox(height: 16),

            // ===== LAT LONG INPUT =====
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _latController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Latitude',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _lngController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Longitude',
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ===== BUTTON =====
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleSubmit,
                child: Text(widget.submitLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}