import 'package:flutter/material.dart';
import 'package:supabase_upload_image/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://lnaobowtncbaswpuhihy.supabase.co';
const supabasekey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxuYW9ib3d0bmNiYXN3cHVoaWh5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NzM5NDcsImV4cCI6MjA4MTA0OTk0N30.a-jmZ7Xcmm-bFJ4GseIp-xIsE2Ik0Nx0GNuUML5GYfo'; 
Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
await Supabase.initialize(url: supabaseUrl, anonKey: supabasekey);
runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Supabase Upload Image',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}