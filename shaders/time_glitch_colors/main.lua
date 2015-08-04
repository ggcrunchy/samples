--- A small demo to show glitches often effected by growing time.

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

local UpTo = 8191

do

	-- Kernel --
	local kernel = { category = "generator", name = "glitch" }

	kernel.vertexData = {
		{
			name = "x",
			default = 1, min = 0, max = UpTo,
			index = 0
		}
	}

	kernel.fragment = [[
		P_COLOR vec4 FragmentKernel (P_UV vec2 uv)
		{
			return vec4(sin(uv.x * CoronaVertexUserData.x) * .5 + .5, .5, 0., 1.);
		}
	]]

	graphics.defineEffect(kernel)
end

local rect = display.newRect(display.contentCenterX, display.contentCenterY, 400, 300)
local text = display.newText("Multiplier: 1", 0, 50, native.systemFont, 24)

text.anchorX, text.x = 0, 100

rect.fill.effect = "generator.custom.glitch"

--
local widget = require("widget")

local slider = widget.newSlider{
	top = 50, left = display.contentWidth - 125,
	height = display.contentHeight - 100, orientation = "vertical",
	value = 0,
	listener = function(event)
		local amount = 1 + (UpTo - 1) * event.value / 100

		rect.fill.effect.x = amount
		text.text = ("Multiplier: %.2f"):format(amount)
	end
}

-- Observation = occurs around 85%, I'm guessing from visual inspection
-- 8192 * .85 = 6963.2, divided in turn by 2 * pi ~ 1108.228, just over 1024