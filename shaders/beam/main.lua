--- A small demo to show a beam effect.

--
-- Permission is hereby granted, free of charge, to any person obtaining
-- a copy of this software and associated documentation files (the
-- "Software"), to deal in the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish,
-- distribute, sublicense, and/or sell copies of the Software, and to
-- permit persons to whom the Software is furnished to do so, subject to
-- the following conditions:
--
-- The above copyright notice and this permission notice shall be
-- included in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-- IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
-- CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
-- TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
-- SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--
-- [ MIT license: http://www.opensource.org/licenses/mit-license.php ]
--

do
	-- Kernel --
	local kernel = { category = "generator", group = "enemy_attack", name = "beam" }

	kernel.vertexData = {
		{
			name = "width",
			default = .17, min = 0, max = 1,
			index = 0
		},
		{
			name = "taper",
			default = .34, min = 0, max = .5,
			index = 1
		},
		{
			name = "frequency",
			default = .017, min = 0, max = 1,
			index = 2
		},
		{
			name = "falloff",
			default = 3.7, min = 0, max = 5,
			index = 3
		}
	}

	kernel.isTimeDependent = true

	kernel.fragment = [[
		// Created by inigo quilez - iq/2013
		// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
		P_POSITION float hash (P_UV float n)
		{
		#if GL_FRAGMENT_PRECISION_HIGH
			return fract(sin(n) * 4375.85453);
		#else
			return fract(sin(n) * 43.7585453);
		#endif
			// TODO: Find a way to detect the precision and tune these!
		}

		// Created by inigo quilez - iq/2013
		// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
		P_POSITION float noise (P_POSITION vec2 x)
		{
			P_POSITION vec2 p = floor(x);
			P_POSITION vec2 f = fract(x);

			f = f * f * (3.0 - 2.0 * f);

			P_POSITION float n = p.x + p.y * 57.0;

			return mix(mix(hash(n +  0.0), hash(n +  1.0), f.x),
					    mix(hash(n + 57.0), hash(n + 58.0), f.x), f.y);
		}

		P_POSITION float Height (P_POSITION vec2 foot, P_POSITION float z)
		{
			// Try to tame large time values.
			P_POSITION float t = 256. - abs(256. - mod(CoronaTotalTime, 512.));

			// Find a height along a curve and displace it by some noise.
			P_POSITION float taper_base = max(0., CoronaVertexUserData.y); // y = taper factor
			P_POSITION float x = smoothstep(taper_base, .5, abs(foot.x - .5));
			P_POSITION float y = CoronaVertexUserData.x * (1. - x * x); // x = width

			return y * (.875 + noise(-foot * (1023. * CoronaVertexUserData.z) + vec2(8.9, z * 1.7) * t) * .125); // z = frequency
		}

		P_COLOR vec4 FragmentKernel (P_UV vec2 uv)
		{
			P_COLOR vec4 color = CoronaColorScale(vec4(1.));

			// Figure out the height (which differs above and below the line) at this x-offset.
			// Find the ratio between the line-to-uv vertical distance and this height.
			P_POSITION vec2 foot = vec2(uv.x, .5);
			P_POSITION vec2 to_uv = uv - foot;
			P_POSITION float h = Height(foot, sign(to_uv.y));
			P_POSITION float ratio = abs(to_uv.y) / max(h, .0001);

			// Use the ratio to blend from a solid white core to the color (bleed in a little
			// bit of white according to the height, too). Feather away pixels with ratio > 1
			// to avoid both a dark translucent overlay and sharp edges.
			h *= .17 * (1. + noise(vec2(uv.x, h)));

			P_COLOR float white = 1. + pow(max(1. - ratio, 0.), .47);
			P_COLOR vec3 mixed = mix(vec3(white), color.rgb, 1. - exp(-CoronaVertexUserData.w * ratio) * (1. - h)); // w = falloff

			return vec4(min(mixed, 1.), color.a) * smoothstep(-.267, 0., 1. - ratio);
		}
	]]

	graphics.defineEffect(kernel)
end
--[[
local a = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
a:setFillColor(0, 1, 0)
]]
--
local rect = display.newRect(0, display.contentCenterY, 300, 100)

rect.anchorX, rect.x = 0, display.contentCenterX

rect:setFillColor(0, 0, 1)--1, 0, 0)

rect.fill.effect = "generator.enemy_attack.beam"

Runtime:addEventListener("enterFrame", function(event)
	rect.rotation = (event.time * 360 * .11 / 1000) % 360
end)