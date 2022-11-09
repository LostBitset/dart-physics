typedef Vec = List<num>;

class ParticleState {
	final Vec x;
	final Vec v;

	const ParticleState(this.x, this.v);
}

typedef Trajectory = Iterable<ParticleState>;

abstract class Kinematic {
	Vec get v_0;
	Vec get a;

	Trajectory traj(num timestep) sync* {
		var v = List<num>.from(v_0);
		var dim = v.length;
		var x = List<num>.filled(dim, 0.0);
		while (true) {
			for (int i = 0; i < dim; i++) {
				v[i] += a[i] * timestep;
				x[i] += v[i] * timestep;
			}
			yield ParticleState(x, v);
		}
	}
}

class Dart extends Kinematic {
	@override final Vec v_0;
	@override final Vec a = [-9.8, 0.0, 0.0];

	Dart(this.v_0);
}

