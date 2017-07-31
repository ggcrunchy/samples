--- Centers, figure D-4.

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

--
local scale, xshift, yshift = 2.3, -45, 150
local px, py = 160 + xshift, 310 + yshift
local qx, qy = px + (110 + xshift - px) * scale, py + (250 + yshift - py) * scale
local rx, ry = px + (210 + xshift - px) * scale, py + (260 + yshift - py) * scale

--
local circles, contacts = centers.Excircles(px, py, qx, qy, rx, ry, true)
local circ, contact = circles[3], contacts[3]
local mx, my = (contact.a.x + contact.b.x) / 2, (contact.a.y + contact.b.y) / 2

--
local T = triangle.New()

T:SetVertexPos(1, contact.b.x, contact.b.y)
T:SetVertexPos(2, mx, my)
T:SetVertexPos(3, rx, ry)

T:LabelAngle(1, "α", { radius = 60, angle_time = .6 })
T:LabelSide(3, "B - B'", { align = 180, text_offset = 18 })

--
local U = triangle.New()

U:SetVertexPos(1, T:GetVertexPos(1))
U:SetVertexPos(2, circ.x, circ.y)
U:SetVertexPos(3, mx, my)

U:LabelSide(1, "r", { text_offset = 15 })
U:LabelAngle(2, "α", { radius = 55 })
U:MarkAngle(3, 1, { angle_offset = .15 })

--
local L = triangle.New()

L:SetVertexPos(1, qx, qy)
L:SetVertexPos(2, circ.x, circ.y)
L:SetVertexPos(3, contact.b.x, contact.b.y)

L:SetSideStyle(1, "hide")
L:SetSideStyle(2, "hide")
L:SetSideStyle(3, "dashed")
L:MarkAngle(3, 1, { angle_offset = .15 })

--
local R = triangle.New()

R:SetVertexPos(1, mx, my)
R:SetVertexPos(2, contact.a.x, contact.a.y)
R:SetVertexPos(3, rx, ry)

R:SetSideStyle(1, "dashed")
R:SetSideStyle(2, "dashed")
R:SetSideStyle(3, "hide")

--
helpers.Mark(circ.x, circ.y)
helpers.Mark(mx, my)
helpers.Mark(contact.b.x, contact.b.y)
helpers.Point(rx, ry, 7)