--- Triangles, figure B-1.

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

-- Modules --
local triangle = require("triangle")

-- --
local CW, CH = display.contentWidth, display.contentHeight
local MidX = .5 * CW
local MidY = .6 * CH
local Radius = .3 * CW

local circle = display.newCircle(MidX, MidY, Radius)

circle:setFillColor(0, 0)
circle:setStrokeColor(0)

circle.strokeWidth = 4

local block = display.newRect(MidX, MidY, CW, CH)

block.anchorY = 0

block:setFillColor(.7)

--
local function Pos (ca, sa, scale)
	local offset = Radius * scale

	return MidX + offset * ca, MidY - offset * sa
end

for _, degs in ipairs{ 0, 37, 71, 90, 116, 151, 180 } do
	local rads = math.rad(degs)
	local ca, sa = math.cos(rads), math.sin(rads)
	local x, y = Pos(ca, sa, 1.35)
	local str = display.newText(("%i°"):format(degs), x, y, native.systemFontBold, 25)
	local x1, y1 = Pos(ca, sa, .9)
	local x2, y2 = Pos(ca, sa, 1.1)
	local slash = display.newLine(x1, y1, x2, y2)

	slash:setStrokeColor(0)

	slash.strokeWidth = 3

	str:setTextColor(0)

	if degs % 90 ~= 0 then
		str.rotation = degs < 90 and -degs or 180 - degs
	end
end
-- "dfdfdf
