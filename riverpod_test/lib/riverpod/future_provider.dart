import 'package:flutter_riverpod/flutter_riverpod.dart';

final futureProvider = FutureProvider((ref) async => await Future.delayed(
    const Duration(seconds: 2), () => List.generate(5, (e) => e)));
