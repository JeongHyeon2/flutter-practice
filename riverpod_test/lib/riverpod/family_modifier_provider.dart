import 'package:flutter_riverpod/flutter_riverpod.dart';

final familyModifierProvider = StateProvider.family<List<int>, int>(
    (ref, data) => List.generate(5, (index) => index * data));
