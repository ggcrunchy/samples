--- Triangles, figure H-3.

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
local BottomY = .75 * CH
local TopY = .25 * CH
local LeftX = .15 * CW
local MidX = .4 * CW
local RightX = .85 * CW

--
local T = triangle.New()

T:SetVertexPos(1, LeftX, BottomY)
T:SetVertexPos(2, MidX, TopY)
T:SetVertexPos(3, MidX, BottomY)

T:LabelSide(3, "L")

local U = triangle.New()

U:SetVertexPos(1, MidX, BottomY)
U:SetVertexPos(2, MidX, TopY)
U:SetVertexPos(3, RightX, BottomY)

U:MarkAngle(1, 1)
U:LabelSide(3, "R")

local UL = triangle.New()

UL:SetVertexPos(1, LeftX, TopY)
UL:SetVertexPos(2, MidX, TopY)
UL:SetVertexPos(3, LeftX, BottomY)

UL:SetSideStyle(1, "dashed")
UL:SetSideStyle(3, "dashed")
UL:LabelSide(1, "w", { t = 1.4, text_offset = 30 })

local wbounds = UL:GetSideLabel(1).contentBounds
local wy = (wbounds.yMin + wbounds.yMax) / 2

local function Segment (x1, y1, x2, y2)
	local seg = display.newLine(x1, y1, x2 or x1, y2 or y1)

	seg:setStrokeColor(0)

	seg.strokeWidth = 4
end

Segment(LeftX, wy, wbounds.xMin - 20, false)
Segment(wbounds.xMax + 20, wy, RightX, false)
Segment(LeftX, wy - 10, false, wy + 10)
Segment(RightX, wy - 10, false, wy + 10)

local UR = triangle.New()

UR:SetVertexPos(1, MidX, TopY)
UR:SetVertexPos(2, RightX, TopY)
UR:SetVertexPos(3, RightX, BottomY)

UR:SetSideStyle(1, "dashed")
UR:SetSideStyle(2, "dashed")
UR:LabelSide(2, "h")