/*
* FLINT PARTICLE SYSTEM
* .....................
* 
* Author: Richard Lord
* Copyright (c) Richard Lord 2008-2011
* http://flintparticles.org
* 
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

package org.flintparticles.threed.actions;

import flash.geom.Vector3D;
import org.flintparticles.common.particles.Particle;
import org.flintparticles.common.actions.ActionBase;
import org.flintparticles.common.emitters.Emitter;
import org.flintparticles.threed.particles.Particle3D;

/**
 * The RotationalFriction action applies friction to the particle's rotational movement
 * to slow it down when it's rotating. The frictional force is constant, irrespective 
 * of how fast the particle is rotating. For forces proportional to the particle's 
 * angular velocity, use one of the rotational drag effects -
 * RotationalLinearDrag and RotationalQuadraticDrag.
 */
class RotationalFriction extends ActionBase
{
	public var friction(get, set):Float;
	
	private var _friction:Float;
	
	/**
	 * The constructor creates a RotationalFriction action for use by 
	 * an emitter. To add a RotationalFriction to all particles created by an emitter, 
	 * use the emitter's addAction method.
	 * 
	 * @see org.flintparticles.common.emitters.Emitter#addAction()
	 * 
	 * @param friction The amount of friction. A higher number produces a stronger frictional force.
	 */
	public function new( friction:Float = 0 )
	{
		super();
		this.friction = friction;
	}
	
	/**
	 * The amount of friction. A higher number produces a stronger frictional force.
	 */
	private function get_friction():Float
	{
		return _friction;
	}
	private function set_friction( value:Float ):Float
	{
		_friction = value;
		return _friction;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
		var v : Vector3D = cast( particle, Particle3D ).angVelocity;
		if ( v.x == 0 || v.y ==0 || v.z == 0 )
		{
			return;
		}
		var scale:Float = 1 - ( _friction * time ) / ( v.length * cast( particle, Particle3D ).inertia );
		if( scale < 0 )
		{
			v.x = 0;
			v.y = 0;
			v.z = 0;
		}
		else
		{
			v.scaleBy( scale );
		}
	}
}
