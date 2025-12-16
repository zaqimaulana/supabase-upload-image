import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

 @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _publicImageUrl;
  bool _isUploading = false;

  Future<void> _pickAndUploadToPublicBucket() async {
    final picker = ImagePicker();
    
    final picked = await picker.pickImage(source: ImageSource.gallery);

    
    if (picked == null) return;

    setState(() => _isUploading = true);

    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${picked.name}';
      final filePath = 'uploads/$fileName';

      if (kIsWeb) {
        final bytes = await picked.readAsBytes();
        await Supabase.instance.client.storage
            .from('bucket_images')
            .uploadBinary(
              filePath,
              bytes,
              fileOptions: const FileOptions(contentType: 'image/png'),
            );
      } else {
        final file = File(picked.path);
        await Supabase.instance.client.storage
            .from('bucket_images')
            .upload(filePath, file);
      }

      final publicUrl = Supabase.instance.client.storage
          .from('Bucket_images')
          .getPublicUrl(filePath);

      setState(() {
        _publicImageUrl = publicUrl;
      });
    } catch (e) {
      debugPrint('Error upload: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal upload: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supabase Upload Image'),
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}