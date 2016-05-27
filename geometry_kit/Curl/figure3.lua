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
local helpers = require("helpers")
local triangle = require("triangle")

-- --
local CX, CY = 150, 300

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
helpers.TextBelow("D", x2 + .5, x1 + w, y2 - 20, -15, 18)

local _, tick1 = helpers.TextBelow("A", x1 - X + .5, x1, y1, 13, 18)
local x0 = tick1.x

helpers.HLine(x0 - 30, x0 + 1, y1)

--
local texts, _, lines = helpers.TextBelow_Multi({
	"R", x1 + R + 1,
	"B", x1 + R + Y,
	" ", x1 + w
}, x1, y1, 13, 18)

for i = 1, #lines do
	lines[i]:removeSelf()
end

--
local mid = texts[3]
local hline = helpers.HLine(mid.x - 12, mid.x + 12, mid.y - 5.5)
local text = helpers.Text("½πR - R", mid.x - 15, hline.y + 35, 18)
local rect = display.newRoundedRect(text.x, text.y, text.width + 20, text.height + 5, 16)

helpers.VLine(mid.x, hline.y, text.y - rect.path.height / 2)

rect:setFillColor(0, 0)
rect:setStrokeColor(0)

rect.strokeWidth = 2

--
helpers.TextBetween("πR", x0, x1 + w, y2 - 60, 4, 18)