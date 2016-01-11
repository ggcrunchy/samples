--- Triangles, figure 15.

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
local BottomY = .45 * CH
local TopY = .25 * CH
local LeftX = .2 * CW
local MidX = .45 * CW
local RightX = .75 * CW

--
local T = triangle.New()

local M = (TopY - BottomY) / (RightX - LeftX)

local function Y (y1, x)
	return y1 + M * x
end

T:SetVertexPos(1, LeftX, BottomY)
T:SetVertexPos(2, MidX, Y(BottomY, MidX - LeftX))
T:SetVertexPos(3, MidX, BottomY)

local function Segment (x1, y1, x2, y2)
	local seg = display.newLine(x1, y1, x2 or x1, y2)

	seg:setStrokeColor(0)

	seg.strokeWidth = 4
end

local function LabelRange (T, right)
	local label = T:GetSideLabel(1)
	local wx, wy, wbounds = label.x, label.y, label.contentBounds
	local lefty, righty = Y(wy, LeftX - wx), Y(wy, right - wx)
	local inner_leftx, inner_rightx = wbounds.xMin - 3, wbounds.xMax + 3
	local inner_lefty = Y(wy, inner_leftx - wx)
	local inner_righty = Y(wy, inner_rightx - wx)

	Segment(LeftX, lefty, inner_leftx, inner_lefty)
	Segment(inner_rightx, inner_righty, right, righty)
	Segment(LeftX, lefty - 10, false, lefty + 10)
	Segment(right, righty - 10, false, righty + 10)
end

T:MarkAngle(1, 1, { angle_offset = .3 })
T:LabelSide(1, "z1", { align = true, t = .65 })
T:LabelSide(2, "h1")

LabelRange(T, MidX)

local U = triangle.New()

U:SetVertexPos(1, LeftX, BottomY)
U:SetVertexPos(2, RightX, TopY)
U:SetVertexPos(3, RightX, BottomY)

U:LabelSide(1, "z2", { align = true, text_offset = 55 })
U:LabelSide(2, "h2")

LabelRange(U, RightX)