--- Centers, figure D-2.

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
local scale, xshift, yshift = 1.65, -5, 50
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
local T1 = triangle.New()

T1:SetVertexPos(1, contact.c.x, contact.c.y)
T1:SetVertexPos(2, circ.x, circ.y)
T1:SetVertexPos(3, contact.b.x, contact.b.y)

T1:MarkSide(1, 1)
T1:MarkSide(2, 1)

local T2 = triangle.New()

T2:SetVertexPos(1, T1:GetVertexPos(1))
T2:SetVertexPos(2, T1:GetVertexPos(3))
T2:SetVertexPos(3, qx, qy)

T2:SetSideStyle(1, "hide")
T2:MarkAngle(1, 2, { angle_offset = .23 })
T2:MarkAngle(2, 2, { angle_offset = .37, angle_spacing = .11 })
T2:LabelSide(2, "B'", { align = true, text_offset = 18, size = 18 })

local side2 = T2:GetSideLabel(2)

side2.rotation = side2.rotation + 180

helpers.PutRotatedObjectBetween(side2, qx, (T2:GetVertexPos(2)))

local T3 = triangle.New()

T3:SetVertexPos(1, T1:GetVertexPos(3))
T3:SetVertexPos(2, circ.x, circ.y)
T3:SetVertexPos(3, contact.a.x, contact.a.y)

T3:SetSideStyle(1, "hide")
T3:MarkSide(2, 1)

local T4 = triangle.New()

T4:SetVertexPos(1, T1:GetVertexPos(3))
T4:SetVertexPos(2, T3:GetVertexPos(3))
T4:SetVertexPos(3, rx, ry)

T4:SetSideStyle(1, "hide")
T4:MarkAngle(1, 1, { angle_offset = .21 })
T4:MarkAngle(2, 1, { angle_offset = .33 })
T4:LabelSide(3, "B - B'", { align = true, text_offset = 18, size = 18 })

local side3 = T4:GetSideLabel(3)

side3.rotation = side3.rotation + 180

helpers.PutRotatedObjectBetween(side3, T4:GetVertexPos(1), rx)

--
helpers.Mark(circ.x, circ.y)
helpers.Mark(contact.b.x, contact.b.y)

--
helpers.Point(qx, qy, 6)
helpers.Point(rx, ry, 6)

helpers.Text("q", qx - 17, qy + 3, 21):setTextColor(.15)
helpers.Text("r", rx + 13, ry + 9, 23):setTextColor(.15)

--
local xl, yl = contact.b.x - 37, contact.b.y - 85
local xr, yr = contact.b.x + 43, contact.b.y - 87

helpers.Line(contact.b.x - 20, contact.b.y - 5, xl, yl):setStrokeColor(.4)
helpers.Line(contact.b.x + 20, contact.b.y - 5, xr, yr):setStrokeColor(.4)

local ltext = helpers.Text("β", xl + 5, yl - 13)
local lr = display.newRoundedRect(ltext.x, ltext.y, ltext.width + 4, ltext.height + 6, 9)
local rtext = helpers.Text("α", xr + 5, yr - 13)
local rr = display.newRoundedRect(rtext.x, rtext.y, rtext.width + 4, rtext.height + 6, 9)

for _, rect in ipairs{ lr, rr } do
	rect:setFillColor(0, 0)
	rect:setStrokeColor(.4)

	rect.strokeWidth = 3
end