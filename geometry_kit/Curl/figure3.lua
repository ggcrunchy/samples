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
A:SetCenter(100, 300)
A:SetAngles(270, 40)

--
local B = A:Clone()

B:SetAngles(20, 90)
B:SetStyle("dashed")

local R, x1, y1 = A:GetRadius(), A:GetPos(1)
local x2, y2 = A:GetPos(0)
local X, Y, D = 30, 25, .5 * math.pi * R - R
local w = R + Y + D

--
local T = triangle.New()

T:SetVertexPos(1, A:GetCenter())
T:SetVertexPos(2, x1, y1)
T:SetVertexPos(3, x2, y2)

T:MarkAngle(1, 1, { angle_offset = .2 })
T:LabelAngle(1, "α")
T:SetSideStyle(2, "hide")

--
helpers.TextBelow("D", x2 + .5, x1 + w, y2 - 20, -15, { size = 18 })

local _, tick1 = helpers.TextBelow("A", x1 - X + .5, x1, y1, 13, { size = 18 })
local x0 = tick1.x

helpers.HLine(x0 - 30, x0 + 1, y1)

--
local texts = helpers.TextBelow_Multi({
	"R", x1 + R + 1,
	"B", x1 + R + Y,
	" ", x1 + w
}, x1, y1, 13, { size = 18, line_style = "dashed" })

--
local mid = texts[3]
local hline = helpers.HLine(mid.x - 12, mid.x + 12, mid.y - 5.5)
local text = helpers.Text("½πR - R", mid.x - 15, hline.y + 35, { size = 18 })
local rect = display.newRoundedRect(text.x, text.y, text.width + 20, text.height + 5, 16)

helpers.VLine(mid.x, hline.y, text.y - rect.path.height / 2)

rect:setFillColor(0, 0)
rect:setStrokeColor(0)

rect.strokeWidth = 2

--
helpers.TextBetween("πR", x0, x1 + w, y2 - 60, { margin = 4, size = 18 })