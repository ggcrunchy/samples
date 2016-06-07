--- Circles, figure S-4.

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
local centers = require("centers")

local function Circle (x, y, r, g, b)
	local circ = display.newCircle(x, y, 6)

	circ:setFillColor(r, g, b)

	circ.strokeWidth = 2
end

local function Line (x1, y1, x2, y2)
	local line = display.newLine(x1, y1, x2, y2)

	line:setStrokeColor(.2, .4)

	line.strokeWidth = 2
end

local px, py, qx, qy, rx, ry = 250, 270, 100, 300, 50, 200

Line(px, py, qx, qy)
Line(qx, qy, rx, ry)
Line(rx, ry, px, py)
Line(px, py, px + 2 * (px - qx), py + 2 * (py - qy))
Line(px, py, px + 2 * (px - rx), py + 2 * (py - ry))
Line(qx, qy, qx + 2 * (qx - px), qy + 2 * (qy - py))
Line(qx, qy, qx + 2 * (qx - rx), qy + 2 * (qy - ry))
Line(rx, ry, rx + 2 * (rx - px), ry + 2 * (ry - py))
Line(rx, ry, rx + 2 * (rx - qx), ry + 2 * (ry - qy))

local circles, contacts, extouch = centers.Excircles(px, py, qx, qy, rx, ry, true, true)

local function DrawCircle (x, y, r)
	local cc = display.newCircle(x, y, r)

	cc:setFillColor(0, 0)
	cc:setStrokeColor(.4)

	cc.strokeWidth = 2
end

for i, circ in ipairs(circles) do
	DrawCircle(circ.x, circ.y, circ.r)

	for k, v in pairs(contacts[i]) do
		Circle(v.x, v.y, 0, 1, 1)

		if k == "b" then
			print("COMP", v.x, v.y, extouch[i].x, extouch[i].y)
		end
	end
end

Circle(px, py, 1, 0, 0)
Circle(qx, qy, 0, 1, 0)
Circle(rx, ry, 0, 0, 1)

DrawCircle(centers.Incircle(px, py, qx, qy, rx, ry))
DrawCircle(centers.NinePointCircle_Midpoints(px, py, qx, qy, rx, ry))

require("helpers").Mark(centers.Orthocenter(px, py, qx, qy, rx, ry))

print("Nine-point (midpoints): ", centers.NinePointCircle_Midpoints(px, py, qx, qy, rx, ry))
print("Nine-point (orthocenter-corners): ", centers.NinePointCircle_OrthocenterMidpoints(px, py, qx, qy, rx, ry))
print("Nine-point (orthic triangle): ", centers.NinePointCircle_OrthicTriangle(px, py, qx, qy, rx, ry))