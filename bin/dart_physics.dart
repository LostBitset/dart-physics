import 'package:dart_physics/dart_physics.dart';

void main(List<String> arguments) {
	var dart = Dart([0.1, 0.2, 0.8]);
	for (final state in dart.traj(0.01).take(10)) {
		var count = (state.x[2] * 1000).round();
		print('*' * count);
	}
}

