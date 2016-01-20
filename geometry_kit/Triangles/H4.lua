--- Triangles, figure H-4.

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
local A4 = require("Triangles.A4")

A4.T1:LabelSide(3, "R")
A4.T2:LabelSide(1, "h", { t = .35, text_offset = 15 })

local leftx, topy = A4.T2:GetVertexPos(2)
local rightx, bottomy = A4.T1:GetVertexPos(3)

local UR = triangle.New()

UR:SetVertexPos(1, leftx, topy)
UR:SetVertexPos(2, rightx, topy)
UR:SetVertexPos(3, rightx, bottomy)

for i = 1, 3 do
	UR:SetSideStyle(i, "dashed")
end

UR:LabelSide(1, "w", { text_offset = 30 })

local wbounds = UR:GetSideLabel(1).contentBounds
local wy = (wbounds.yMin + wbounds.yMax) / 2

local function Segment (x1, y1, x2, y2)
	local seg = display.newLine(x1, y1, x2 or x1, y2 or y1)

	seg:setStrokeColor(0)

	seg.strokeWidth = 4
end

Segment(leftx, wy, wbounds.xMin - 20, false)
Segment(wbounds.xMax + 20, wy, rightx, false)
Segment(leftx, wy - 10, false, wy + 10)
Segment(rightx, wy - 10, false, wy + 10)