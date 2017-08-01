--- Centers, figure D-5.

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
local math2d_ex = require("math2d_ex")
local triangle = require("triangle")

--
local scale, xshift, yshift = 1.95, -25, 50
local px, py = 160 + xshift, 310 + yshift
local qx, qy = px + (110 + xshift - px) * scale, py + (250 + yshift - py) * scale
local rx, ry = px + (210 + xshift - px) * scale, py + (260 + yshift - py) * scale

--
local circles, contacts = centers.Excircles(px, py, qx, qy, rx, ry, true)
local circ, contact = circles[3], contacts[3]
local A = arc.New()

A:SetCenter(circ.x, circ.y)
A:SetRadius(circ.r)
A:SetStyle("dashed")

--
local vx, vy = math2d_ex.ProjectOnto(px - qx, py - qy, rx - qx, ry - qy)
local fx, fy = qx + vx, qy + vy

--
local L = triangle.New()

L:SetVertexPos(1, qx, qy)
L:SetVertexPos(2, fx, fy)
L:SetVertexPos(3, px, py)

L:SetSideStyle(2, "dashed")
L:LabelSide(1, "L", { align = true, size = 19, t = .6, text_offset = -13 })
L:LabelSide(3, "A")

--
local R = triangle.New()

R:SetVertexPos(1, L:GetVertexPos(2))
R:SetVertexPos(2, rx, ry)
R:SetVertexPos(3, px, py)

R:SetSideStyle(3, "hide")
R:LabelSide(1, "R", { align = true, size = 19, text_offset = -13 })
R:LabelSide(2, "C")
R:LabelSide(3, "h", { text_offset = 8, size = 18 })
R:MarkAngle(1, 1, { angle_offset = .15 })
R:MarkAngle(2, 1, { angle_offset = .175 })

--
local UR = triangle.New()

UR:SetVertexPos(1, rx, ry)
UR:SetVertexPos(2, contact.a.x, contact.a.y)
UR:SetVertexPos(3, rx + (rx - qx), ry + (ry - qy))

UR:SetSideStyle(2, "hide")
UR:SetSideStyle(3, "dashed")
UR:MarkAngle(1, 1, { angle_offset = .225 })

--
local U = triangle.New()

U:SetVertexPos(1, qx, qy)
U:SetVertexPos(2, circ.x, circ.y)
U:SetVertexPos(3, contact.b.x, contact.b.y)

for i = 1, 3 do
	U:SetSideStyle(i, i == 2 and "dashed" or "hide")
end

U:MarkAngle(3, 1, { angle_offset = .16 })

--
helpers.Mark(contact.b.x, contact.b.y):setFillColor(0, 0, 1)
helpers.Mark(circ.x, circ.y):setFillColor(1, 0, 0)
helpers.Mark(fx, fy):setFillColor(1, 1, 0)

--
helpers.Point(px, py, 6)
helpers.Point(qx, qy, 6)
helpers.Point(rx, ry, 6)

helpers.Text("p", px - 1, py + 13, 21):setTextColor(.15)
helpers.Text("q", qx - 12, qy + 7, 21):setTextColor(.15)
helpers.Text("r", rx + 5, ry + 12, 23):setTextColor(.15)