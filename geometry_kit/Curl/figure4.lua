--- Curl, figure 4.

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

--- Modules --
local arc = require("arc")
local triangle = require("triangle")

-- --
local CX, CY = 150, 300

--
local function Line (x1, y1, x2, y2)
	local line = display.newLine(x1, y1, x2, y2)

	line:setStrokeColor(0)

	line.strokeWidth = 3

	return line
end

--
local A, A2 = arc.New(), 40

A:SetRadius(70)
A:SetCenter(CX - 50, CY)
A:SetAngles(270, A2)

--
local B = A:Clone()

B:SetAngles(A2, 90)
B:SetStyle("dashed")

local R, x1, y1 = A:GetRadius(), A:GetPos(1)
local x2, y2 = A:GetPos(0)

local T = triangle.New()

T:SetVertexPos(1, A:GetCenter())
T:SetVertexPos(2, x2, y2)
T:SetVertexPos(3, x1, CY - R)

T:SetSideStyle(1, "hide")
T:SetSideStyle(2, "hide")
T:SetSideStyle(3, "dashed")
T:LabelAngle(1, "θ")
T:MarkAngle(1, 2, { angle_offset = .225, angle_spacing = .1 })

--
local U = triangle.New()

U:SetVertexPos(1, A:GetCenter())
U:SetVertexPos(2, x1, y1)
U:SetVertexPos(3, x2, y2)

U:MarkAngle(1, 1, { angle_offset = .2 })
U:LabelAngle(1, "α")
U:SetSideStyle(2, "hide")

--
local function Text (str, x, y, size)
	local text = display.newText(str, x, y, native.systemFontBold, size or 22)

	text:setTextColor(0)

	return text
end

--
local top_line = Line(x1, CY - R - 20, x2, CY - R - 20)
local tick1 = Line(x1, top_line.y - 10, x1, top_line.y + 10)
local tick2 = Line(x2 + .5, top_line.y - 10, x2 + .5, top_line.y + 10)
local top_text = Text("R·sinθ", (tick1.x + tick2.x) / 2, top_line.y - 12, 15)

--
local tick3 = Line(x1, CY + R + 10, x1, CY + R + 30)
local tick4 = Line(x1 + R + .5, CY + R + 10, x1 + R + .5, CY + R + 30)
local bottom_text = Text("R", (tick3.x + tick4.x) / 2, tick3.y + 10, 18)

Line(tick3.x, bottom_text.y, bottom_text.x - 14, bottom_text.y)
Line(bottom_text.x + 14, bottom_text.y, tick4.x, bottom_text.y)