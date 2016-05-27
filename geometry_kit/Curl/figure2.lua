--- Curl, figure 2.

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
local helpers = require("helpers")
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
local A = arc.New()

A:SetRadius(40)
A:SetCenter(CX, CY)
A:SetAngles(270, 90)

local R, x1, y1 = A:GetRadius(), A:GetPos(1)

Line(x1 + 1, y1 + 1, x1 - 70, y1 + 1)

local X, Y, D = 30, 25, math.pi * R

local x2, y2 = A:GetPos(0)

Line(x2, y2, x2 - X, y2)

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
local function Text (str, x, y, size)
	local text = display.newText(str, x, y, native.systemFontBold, size or 22)

	text:setTextColor(0)

	return text
end

--
helpers.TextBelow("D", x2 - X + .5, x2 + w, y2 - 40, -15, 18)
helpers.TextBelow("A", x2 - X + .5, x2, y2, -15, 18)

local _, _, lines = helpers.TextBelow_Multi({
	"R", x1 + R,
	"B", x1 + R + Y,
	"πR", x1 + w
}, x1, y1, 13, 18)

for i = 1, #lines do
	lines[i]:removeSelf()
end