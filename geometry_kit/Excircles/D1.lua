--- Centers, figure D-1.

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
local arc = require("arc")
local centers = require("centers")
local helpers = require("helpers")
local triangle = require("triangle")

--
local px, py, qx, qy, rx, ry = 210, 260, 160, 310, 110, 250
local T = triangle.New()

T:SetVertexPos(1, px, py)
T:SetVertexPos(2, qx, qy)
T:SetVertexPos(3, rx, ry)

helpers.Line(px, py, px + 2 * (px - qx), py + 2 * (py - qy), true)
helpers.Line(px, py, px + 2 * (px - rx), py + 2 * (py - ry), true)
helpers.Line(qx, qy, qx + 2 * (qx - px), qy + 2 * (qy - py), true)
helpers.Line(qx, qy, qx + 2 * (qx - rx), qy + 2 * (qy - ry), true)
helpers.Line(rx, ry, rx + 2 * (rx - px), ry + 2 * (ry - py), true)
helpers.Line(rx, ry, rx + 2 * (rx - qx), ry + 2 * (ry - qy), true)

local circles, contacts = centers.Excircles(px, py, qx, qy, rx, ry, true)

for i, circ in ipairs(circles) do
	local A = arc.New()

	A:SetCenter(circ.x, circ.y)
	A:SetRadius(circ.r)
	A:SetStyle("dashed")

	if i == 1 then
		local cc = contacts[i]

		for _, point in ipairs{
			{ name = "a", index = 1 },
			{ name = "b", index = 1 },
			{ name = "c", index = 3 }
		} do
			local U = triangle.New()

			U:SetVertexPos(1, circ.x, circ.y)
			U:SetVertexPos(2, cc[point.name].x, cc[point.name].y)
			U:SetVertexPos(3, T:GetVertexPos(point.index))

			U:SetSideStyle(2, "hide")
			U:SetSideStyle(3, "hide")
			U:MarkAngle(2, 1, { angle_offset = .25 })
		end

		helpers.Mark(circ.x, circ.y)
	end
end

--
helpers.Point(px, py, 6)
helpers.Point(qx, qy, 6)
helpers.Point(rx, ry, 6)

helpers.Text("p", qx, qy + 20, 21)
helpers.Text("q", rx - 7, ry + 15, 23)
helpers.Text("r", px + 7, py + 15, 21)