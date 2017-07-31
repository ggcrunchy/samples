--- Triangles, figure H-1.

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

local CW, CH = display.contentWidth, display.contentHeight
local Unit = .15 * CW
local TopY = .25 * CH
local BottomY = TopY + 3 * Unit
local LeftX = .2 * CW
local RightX = LeftX + 4 * Unit

--
local T = triangle.New()

T:SetVertexPos(1, LeftX, TopY)
T:SetVertexPos(2, RightX, TopY)
T:SetVertexPos(3, RightX, BottomY)

T:SetSideStyle(3, "hide")
T:LabelSide(1, "4")
T:LabelSide(2, "3")

local U = triangle.New()

U:SetSideStyle(3, "hide")
U:SetVertexPos(1, RightX, BottomY)
U:SetVertexPos(2, LeftX, BottomY)
U:SetVertexPos(3, LeftX, TopY)

local function Segment (x1, y1, x2, y2)
	local seg = display.newLine(x1, y1, x2 or x1, y2 or y1)

	seg:setStrokeColor(0)

	seg.strokeWidth = 3
end

for i = 1, 3 do
	Segment(LeftX + i * Unit, TopY, false, BottomY)
end

for j = 1, 2 do
	Segment(LeftX, TopY + j * Unit, RightX, false)
end

return { T1 = T, T2 = U } -- reused in figure 17