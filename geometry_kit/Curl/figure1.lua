--- Curl, figure 1.

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
local triangle = require("triangle")

-- --
local CX, CY = 100, 300

--
local function Line (x1, y1, x2, y2)
	local line = display.newLine(x1, y1, x2, y2)

	line:setStrokeColor(0)

	line.strokeWidth = 3

	return line
end

--
local A, R = arc.New(), 110

A:SetRadius(R)
A:SetCenter(CX, CY)
A:SetAngles(270, 360)

local x1, y1 = A:GetPos(1)

Line(x1 + 1, y1 + 1, x1 - 70, y1 + 1)

--
local B, A1, A2 = A:Clone(), 270, 330

B:SetAngles(A1, A2)
A:SetStyle("dashed")

--
local C = B:Clone()

C:SetRadius(R + 10)
C:SetAngles(285, 315)

--
local function Text (str, x, y, size)
	local text = display.newText(str, x, y, native.systemFontBold, size or 22)

	text:setTextColor(0)

	return text
end

--
local lx, ly = C:GetPos(.5)
local dx, dy = lx - CX, ly - CY

Line(lx, ly, lx + dx * .4, ly + dy * .4)
Text("R·θ", lx + dx * .525, ly + dy * .525).rotation = -32.1

--
local T = triangle.New()
local XR, YR = B:GetPos(0)
local XL, YL = B:GetPos(1)

T:SetVertexPos(1, CX, CY)
T:SetVertexPos(2, XR, YR)
T:SetVertexPos(3, XL, YL)

T:MarkAngle(1, 1, { angle_offset = .2 })
T:LabelAngle(1, "θ")
T:SetSideStyle(2, "hide")

--
local angle = math.rad(A2 - A1)
local D = A:GetRadius() * (angle - math.sin(angle))

--
local U = triangle.New()

U:SetVertexPos(1, x1, y1)
U:SetVertexPos(2, XR + D, y1)
U:SetVertexPos(3, x1, y1 + 100)

U:SetSideStyle(1, "dashed")
U:SetSideStyle(2, "hide")
U:SetSideStyle(3, "hide")

--
local top_line = Line(XL, CY - 20, XR + D, CY - 20)
local tick1 = Line(XL, top_line.y - 10, XL, top_line.y + 10)
local tick2 = Line(XR, top_line.y - 10, XR, top_line.y + 10)
local tick3 = Line(XR + D, top_line.y - 10, XR + D, top_line.y + 10)

Text("R·sinθ", (tick1.x + tick2.x) / 2, tick1.y - 5, 18)
Text("D", (tick2.x + tick3.x) / 2, tick1.y - 5, 18)