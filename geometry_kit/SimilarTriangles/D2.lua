--- Similar triangles, figure D-2.

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
local math2d_ex = require("math2d_ex")
local triangle = require("triangle")
local D1 = require("SimilarTriangles.D1")
local helpers = require("helpers")

--
local X1, Y1 = D1.T:GetVertexPos(1)
local X2, Y2 = D1.T:GetVertexPos(2)
local X3, Y3 = D1.T:GetVertexPos(3)
local X4, Y4 = D1.U:GetVertexPos(3)
local dx, dy = math2d_ex.ProjectOnto(X2 - X3, Y2 - Y3, X1 - X3, Y1 - Y3)

--
local L = triangle.New()
local lx, ly = X3 + dx, Y3 + dy

L:SetVertexPos(1, X2, Y2)
L:SetVertexPos(2, lx, ly)
L:SetVertexPos(3, X3, Y3)

L:MarkAngle(1, 2, { angle_offset = .2 })
L:MarkAngle(2, 1, { angle_offset = .15 })
L:SetSideStyle(1, "dashed")
L:SetSideStyle(2, "hide")
L:SetSideStyle(3, "hide")

--
local U = triangle.New()
local ux, uy = X4 + dx, Y4 - dy

U:SetVertexPos(1, X2, Y2)
U:SetVertexPos(2, ux, uy)
U:SetVertexPos(3, X4, Y4)

U:MarkAngle(1, 2, { angle_offset = .2 })
U:MarkAngle(2, 1, { angle_offset = .15 })
U:SetSideStyle(1, "dashed")
U:SetSideStyle(2, "hide")
U:SetSideStyle(3, "hide")

--
local m1 = helpers.Mark(lx, ly)
local m2 = helpers.Mark(X4 + dx, Y4 - dy)

return { L = L, U = U, D1 = D1, m1 = m1, m2 = m2 }