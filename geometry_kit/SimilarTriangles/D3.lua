--- Similar triangles, figure D-3.

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
local triangle = require("triangle")
local D2 = require("SimilarTriangles.D2")

--
D2.L:MarkSide(2, 2, { angle_spacing = .1 })
D2.L:MarkSide(1, 3)
D2.L:SetSideStyle(1, "normal")
D2.U:MarkSide(2, 2, { angle_spacing = .1 })
D2.U:MarkSide(1, 3)
D2.U:SetSideStyle(1, "normal")

--
local XL, YL = D2.L:GetVertexPos(2)
local XU, YU = D2.U:GetVertexPos(2)
local XE, YE = D2.U:GetVertexPos(1)

--
local L = triangle.New()

L:SetVertexPos(1, XL, YL)
L:SetVertexPos(2, XL, YE)
L:SetVertexPos(3, XE, YE)
L:SetSideStyle(1, "dashed")
L:SetSideStyle(2, "dashed")
L:SetSideStyle(3, "hide")
L:MarkAngle(1, 2, { angle_offset = .2 })
L:MarkAngle(2, 1, { angle_offset = .15 })
L:MarkAngle(3, 1, { angle_offset = .15 })

--
local U = triangle.New()

U:SetVertexPos(1, XU, YU)
U:SetVertexPos(2, XU, YE)
U:SetVertexPos(3, XE, YE)
U:SetSideStyle(1, "dashed")
U:SetSideStyle(2, "hide")
U:SetSideStyle(3, "hide")
U:MarkAngle(1, 2, { angle_offset = .2 })
U:MarkAngle(3, 1, { angle_offset = .15 })

--
D2.m1:toFront()
D2.m2:toFront()
D2.D1.m:toFront()

--
local T = triangle.New()

T:SetVertexPos(1, D2.D1.T:GetVertexPos(1))
T:SetVertexPos(2, XU, YU)
T:SetVertexPos(3, XL, YL)
T:MarkAngle(2, 1)
T:MarkAngle(3, 1, { angle_offset = .125 })
T:SetSideStyle(1, "hide")
T:SetSideStyle(2, "hide")
T:SetSideStyle(3, "hide")

return { L = L, U = U, T = T, D2 = D2 }
