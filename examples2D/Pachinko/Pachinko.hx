/*
 * FLINT PARTICLE SYSTEM
 * .....................
 * 
 * Author: Richard Lord
 * Copyright (c) Richard Lord 2008-2011
 * http://flintparticles.org/
 * 
 * Licence Agreement
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
import org.flintparticles.common.counters.TimePeriod;
import org.flintparticles.common.displayobjects.Dot;
import org.flintparticles.common.initializers.CollisionRadiusInit;
import org.flintparticles.common.initializers.SharedImage;
import org.flintparticles.twod.actions.Accelerate;
import org.flintparticles.twod.actions.Collide;
import org.flintparticles.twod.actions.CollisionZone;
import org.flintparticles.twod.actions.DeathZone;
import org.flintparticles.twod.actions.Move;
import org.flintparticles.twod.emitters.Emitter2D;
import org.flintparticles.twod.initializers.Position;
import org.flintparticles.twod.initializers.Velocity;
import org.flintparticles.twod.zones.DiscZone;
import org.flintparticles.twod.zones.LineZone;
import org.flintparticles.twod.zones.PointZone;
import org.flintparticles.twod.zones.RectangleZone;
import flash.geom.Point;

/**
 * @author Richard Lord
 */class Pachinko extends Emitter2D
{

	public function new()
	{
    super ();

		counter = new TimePeriod(100, 1);
		addInitializer(new SharedImage(new Dot(4)));
		addInitializer(new CollisionRadiusInit(5));
		addInitializer(new Position(new LineZone(new Point(130, -5), new Point(350, -5))));
		addInitializer(new Velocity(new DiscZone(new Point(0, 100), 20)));
		addAction(new Move());
		addAction(new Accelerate(0, 100));
		addAction(new Collide());
		addAction(new DeathZone(new RectangleZone(0, 425, 480, 450)));
		addAction(new CollisionZone(new DiscZone(new Point(240, 205), 242), 0.5));
	}

	public function addPin(x : Float, y : Float) : Void
	{
		addAction(new CollisionZone(new PointZone(new Point(x, y)), 0.5));
	}

}

