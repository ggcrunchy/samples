--- Another small demo to show glitches often effected by growing time.

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

local UpTo = 1023

do

	-- Kernel --
	local kernel = { category = "generator", name = "glitch" }

	kernel.vertexData = {
		{
			name = "extend",
			default = 5, 
			min = .25,
			max = 250,
			index = 0
		},
		{
			name = "frequency",
			default = 1.3,
			min = .2,
			max = 8,
			index = 1
		},
		{
			name = "center",
			default = display.contentCenterX, 
			min = 0,
			max = display.contentWidth,
			index = 2
		},
		{
			name = "time",
			default = 0, 
			min = 0,
			max = UpTo,
			index = 3
		}	
	}

	kernel.vertex = [[
		varying P_UV float v_Extension;
		varying P_UV float v_Fraction;
		varying P_UV float v_Angle;

		P_POSITION vec2 VertexKernel (P_POSITION vec2 position)
		{
			P_POSITION float offset = position.x - CoronaVertexUserData.z; // z = center
			P_POSITION float extend = sign(offset) * CoronaVertexUserData.x; // x = extend

			v_Extension = .5 * extend / (offset + extend);
			v_Fraction = (offset + 2. * extend) / (offset + extend);
			v_Angle = 6.28 * (CoronaTexCoord.y + CoronaVertexUserData.w) * CoronaVertexUserData.y; // y = frequency, w = time

			position.x += extend;

			return position;
		}
	]]

	kernel.fragment = [[
		varying P_UV float v_Extension;
		varying P_UV float v_Fraction;
		varying P_UV float v_Angle;

		P_COLOR vec4 FragmentKernel (P_UV vec2 uv)
		{
			uv.s *= v_Fraction;
			uv.s += (sin(v_Angle) - 1.) * v_Extension;

			if (abs(uv.s - .5) > .5) return vec4(0.);

			return CoronaColorScale(texture2D(CoronaSampler0, uv));
		}
	]]

	graphics.defineEffect(kernel)
end

local image = display.newImageRect("Image1.jpg", 400, 300)
local text = display.newText("Time: 0", 0, 50, native.systemFont, 24)

image.x, image.y = display.contentCenterX, display.contentCenterY
text.anchorX, text.x = 0, 100

image.fill.effect = "generator.custom.glitch"

--
local widget = require("widget")

local slider = widget.newSlider{
	top = 50, left = display.contentWidth - 125,
	height = display.contentHeight - 100, orientation = "vertical",
	value = 0,
	listener = function(event)
		local time = UpTo * event.value / 100

		image.fill.effect.time = time
		text.text = ("Time: %.2f"):format(time)
	end
}

-- Observation = seems to be about consistent with first example... if frequency is slightly smaller, not seen