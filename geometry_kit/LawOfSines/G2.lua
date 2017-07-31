--- Circles, figure G-2.

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
local helpers = require("helpers")
local math2d_ex = require("math2d_ex")
local triangle = require("triangle")
local E1 = require("Circles.E1")

--
local x1, y1 = E1.upper:GetVertexPos(1)
local x2, y2 = E1.upper:GetVertexPos(2)
local x3, _ = E1.T:GetVertexPos(3)

--
E1.A:Remove()
E1.upper:Remove()
E1.lower:Remove()
E1.T:Remove()

for i = 1, 2 do
	E1.marks[i]:removeSelf()
end

--
local V, dx, dy = triangle.New(), math2d_ex.ProjectOnto(x1 - x3, 0, x2 - x3, y2 - y1)

V:SetVertexPos(1, x1, y1)
V:SetVertexPos(2, x2, y2)
V:SetVertexPos(3, x3 + dx, y1 + dy)

V:SetSideStyle(1, "hide")
V:SetSideStyle(2, "hide")
V:SetSideStyle(3, "dashed")
V:MarkAngle(3, 1, { angle_offset = .08 })
V:LabelSide(3, "Csina", { align = true, t = .275, text_offset = 14 })

V:GetSideLabel(3):rotate(180)

--
local T = triangle.New()

T:SetVertexPos(1, x1, y1)
T:SetVertexPos(2, x2, y2)
T:SetVertexPos(3, x2, y1)

T:SetSideStyle(2, "dashed")
T:LabelSide(1, "A", { align = true })
T:LabelAngle(1, "b", { radius = 31 })

--
local U = triangle.New()

U:SetVertexPos(1, T:GetVertexPos(3))
U:SetVertexPos(2, T:GetVertexPos(2))
U:SetVertexPos(3, x3, y1)

U:LabelAngle(2, "c", { angle_time = .2 })
U:LabelAngle(3, "a", { angle_time = .4 })
U:MarkAngle(1, 1, { angle_offset = .07 })
U:SetSideStyle(1, "hide")
U:LabelSide(1, "Asinb", { align = true, t = .45, text_offset = 14 })
U:LabelSide(2, "B", { align = true, text_offset = 20 })
U:LabelSide(3, "C", { t = .85 })

--
for _, label in ipairs{ T:GetAngleLabel(1), U:GetAngleLabel(2) } do
	local blotch = display.newCircle(label.parent, label.x, label.y, 12)

	blotch:setFillColor(.7)

	label:toFront()
end