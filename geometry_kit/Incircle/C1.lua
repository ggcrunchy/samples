--- Centers, figure C-1.

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

-- Plugins --
local math2d = require("plugin.math2d")

--
local x1, y1 = 180, 80
local x2, y2 = 240, 270
local x3, y3 = 60, 190
local cx, cy, r, contact = centers.Incircle(x1, y1, x2, y2, x3, y3, true)

--
local A = arc.New()

A:SetCenter(cx, cy)
A:SetRadius(r)
A:SetStyle("dashed")

--
for i, info in ipairs{
	{ px = x3, py = y3, qx = x1, qy = y1, ckey = "c", label = "A", name = "p" },
	{ px = x1, py = y1, qx = x2, qy = y2, ckey = "a", label = "B", name = "q" },
	{ px = x2, py = y2, qx = x3, qy = y3, ckey = "b", label = "C", name = "r" }
} do
	local T1 = triangle.New()

	T1:SetVertexPos(1, cx, cy)
	T1:SetVertexPos(2, info.px, info.py)
	T1:SetVertexPos(3, contact[info.ckey].x, contact[info.ckey].y)

	T1:SetSideStyle(1, "hide")
	T1:LabelSide(2, ("%s - %s'"):format(info.label, info.label), { align = true, text_offset = 17 })
	T1:MarkAngle(3, 1, { angle_offset = .25 })

	local T2 = triangle.New()

	T2:SetVertexPos(1, cx, cy)
	T2:SetVertexPos(2, T1:GetVertexPos(3))
	T2:SetVertexPos(3, info.qx, info.qy)

	T2:SetSideStyle(1, "hide")
	T2:SetSideStyle(3, "hide")
	T2:LabelSide(2, ("%s'"):format(info.label), { align = true, text_offset = 17 })

	if i == 3 then
		for _, text in ipairs{ T1, T2 } do
			local label = text:GetSideLabel(2)

			label.rotation = label.rotation + 180
		end
	end

	helpers.Point(info.px, info.py, 9)

	local dx, dy = math2d.normalize(info.px - cx, info.py - cy)

	dx, dy = math2d.scale(dx, dy, 23)

	helpers.Text(info.name, info.px + dx, info.py + dy, 24)
end

--
helpers.Mark(cx, cy)