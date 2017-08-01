--- Centers, figure C-1.

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
local centers = require("centers")
local helpers = require("helpers")
local triangle = require("triangle")

-- Plugins --
local math2d = require("plugin.math2d")

--
local xshift = 35
local x1, y1, scale = 180 + xshift, 80, 1.8
local x2, y2 = x1 + (240 + xshift - x1) * scale, y1 + (270 - y1) * scale
local x3, y3 = x1 + (60 + xshift - x1) * scale, y1 + (190 - y1) * scale
local cx, cy, r, contact = centers.Incircle(x1, y1, x2, y2, x3, y3, true)

--
local A = arc.New()

A:SetCenter(cx, cy)
A:SetRadius(r)
A:SetAngles(-20, 200)
A:SetStyle("dashed")

--
local T = triangle.New()

T:SetVertexPos(1, cx, cy)
T:SetVertexPos(2, contact.c.x, contact.c.y)
T:SetVertexPos(3, contact.a.x, contact.a.y)

T:LabelSide(1, "r", { align = true, text_offset = 13 })
T:LabelSide(3, "r", { align = true, text_offset = 13 })
T:MarkAngle(2, 1, { angle_offset = .175 })
T:MarkAngle(3, 1, { angle_offset = .3 })

for i = 1, 2 do
	local label = T:GetSideLabel(i == 1 and 1 or 3)
	
	label.rotation = label.rotation + 180
end

--
helpers.Mark(cx, cy):setFillColor(1, 0, 0)

--
local lx, ly = math2d.normalize(contact.c.x - x1, contact.c.y - y1)
local rx, ry = math2d.normalize(contact.a.x - x1, contact.a.y - y1)
local L, R, side = triangle.New(), triangle.New(), 80

L:SetVertexPos(1, contact.c.x + lx * side, contact.c.y + ly * side)
L:SetVertexPos(2, contact.c.x, contact.c.y)
L:SetVertexPos(3, cx, cy)

L:SetSideStyle(2, "hide")
L:SetSideStyle(3, "hide")
L:MarkAngle(2, 1, { angle_offset = .15 })

R:SetVertexPos(1, cx, cy)
R:SetVertexPos(2, contact.a.x, contact.a.y)
R:SetVertexPos(3, contact.a.x + rx * side, contact.a.y + ry * side)

R:SetSideStyle(1, "hide")
R:SetSideStyle(3, "hide")
R:MarkAngle(2, 1, { angle_offset = .2 })

--
local U = triangle.New()

U:SetVertexPos(1, contact.c.x, contact.c.y)
U:SetVertexPos(2, x1, y1)
U:SetVertexPos(3, contact.a.x, contact.a.y)

U:SetSideStyle(3, "hide")
U:LabelSide(1, "A'", { align = true, text_offset = 15 })
U:LabelSide(2, "B - B'", { align = true, text_offset = 15 })

--
local q = helpers.Point(x1, y1, 9)

helpers.Text("q", q.x + 5, q.y - 25)