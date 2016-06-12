--- Circles, figure G-5.

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
local centers = require("centers")
local helpers = require("helpers")
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
local T = triangle.New()

T:SetVertexPos(1, x1, y1)
T:SetVertexPos(2, x2, y2)
T:SetVertexPos(3, x3, y1)

--
local ox, oy, orthic = centers.Orthocenter(x1, y1, x2, y2, x3, y1, true)

--
local T1 = triangle.New()

T1:SetVertexPos(1, x1, y1)
T1:SetVertexPos(2, orthic.a.x, orthic.a.y)
T1:SetVertexPos(3, x3, y1)

T1:SetSideStyle(1, "hide")
T1:SetSideStyle(2, "dashed")
T1:SetSideStyle(3, "hide")
T1:MarkAngle(2, 1, { angle_offset = .08 })

--
local T2 = triangle.New()

T2:SetVertexPos(1, x1, y1)
T2:SetVertexPos(2, x2, y2)
T2:SetVertexPos(3, orthic.b.x, orthic.b.y)

T2:SetSideStyle(1, "hide")
T2:SetSideStyle(2, "dashed")
T2:SetSideStyle(3, "hide")
T2:MarkAngle(3, 1, { angle_offset = .2 })

--
local T3 = triangle.New()

T3:SetVertexPos(1, x1, y1)
T3:SetVertexPos(2, orthic.c.x, orthic.c.y)
T3:SetVertexPos(3, x3, y1)

T3:SetSideStyle(1, "dashed")
T3:SetSideStyle(2, "hide")
T3:SetSideStyle(3, "hide")
T3:MarkAngle(2, 1, { angle_offset = .125 })

--
helpers.Mark(ox, oy)

--
return { T = T, T1 = T1, T2 = T2, T3 = T3, orthic = orthic }