--- Curl, figure 3.

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
local A = arc.New()

A:SetRadius(70)
A:SetCenter(CX - 50, CY)
A:SetAngles(270, 40)

--
local B = A:Clone()

B:SetAngles(20, 90)
B:SetStyle("dashed")

local R, x1, y1 = A:GetRadius(), A:GetPos(1)
local x2, y2 = A:GetPos(0)
local X, Y, D = 30, 25, .5 * math.pi * R - R

--
local T = triangle.New()
local w = R + Y + D

T:SetVertexPos(1, x1, y1)
T:SetVertexPos(2, x1 + w, y1)
T:SetVertexPos(3, x1, y1 + 100)

T:SetSideStyle(1, "dashed")
T:SetSideStyle(2, "hide")
T:SetSideStyle(3, "hide")

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
local tick1 = Line(x2 + .5, y2 - 30, x2 + .5, y2 - 10)
local tick2 = Line(x1 + w, y2 - 30, x1 + w, y2 - 10)

Line(tick1.x, y2 - 20, tick2.x, y2 - 20)
Text("D", (tick1.x + tick2.x) / 2, tick1.y - 5, 18)

--
local tick3 = Line(x1 - X + .5, y1 - 10, x1 - X + .5, y1 + 10)
local tick4 = Line(x1, y1 - 10, x1, y1 + 10)

Text("A", (tick3.x + tick4.x) / 2, tick3.y + 23, 18)

Line(tick3.x + 1, y1, tick3.x - 30, y1)
Line(tick3.x, y1, x1, y1)

--
local tick5 = Line(x1, y1 - 10, x1, y1 + 10)
local tick6 = Line(x1 + R + 1, y1 - 10, x1 + R + 1, y1 + 10)
local tick7 = Line(x1 + R + Y, y1 - 10, x1 + R + Y, y1 + 10)
local tick8 = Line(x1 + w, y1 - 10, x1 + w, y1 + 10)

Text("R", (tick5.x + tick6.x) / 2, tick5.y + 23, 18)
Text("B", (tick6.x + tick7.x) / 2, tick6.y + 23, 18)

local mid = (tick7.x + tick8.x) / 2

Line(mid - 12, tick7.y + 15.5, mid + 12, tick7.y + 15.5)
Line(mid, tick7.y + 15, mid, tick7.y + 43)

local text = Text("½π·R - R", mid - 15, tick7.y + 55, 18)
local rect = display.newRoundedRect(text.x, text.y, text.width + 20, text.height + 5, 16)

rect:setFillColor(0, 0)
rect:setStrokeColor(0)

rect.strokeWidth = 2

local top_text = Text("π·R", (tick3.x + tick8.x) / 2, y2 - 60, 18)

Line(tick3.x, top_text.y, top_text.x - 21, top_text.y)
Line(top_text.x + 21, top_text.y, tick8.x, top_text.y)
Line(tick3.x, top_text.y - 10, tick3.x, top_text.y + 10)
Line(tick8.x, top_text.y - 10, tick8.x, top_text.y + 10)