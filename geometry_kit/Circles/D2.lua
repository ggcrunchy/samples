--- Circles, figure D-2.

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
local triangle = require("triangle")
local D1 = require("Circles.D1")

--
local x2, y2 = D1.above:GetVertexPos(3)

D1.A:Remove()
D1.marks[1]:removeSelf()
D1.below:MarkAngle(3, nil)
D1.above:Remove()

--
local x1, x3 = D1.below:GetVertexPos(1), D1.below:GetVertexPos(3)
local scale = (x2 - x1) / (x3 - x1)
local T = helpers.SimilarTriangleVertex(D1.below, scale, 1)

T:LabelSide(1, "cosβ", { align = true, t = .6 })
T:MarkAngle(1, nil)
T:MarkAngle(3, 1)
T:SetSideStyle(1, "hide")
T:SetSideStyle(2, "dashed")
T:SetSideStyle(3, "hide")

--
helpers.PutRotatedObjectBetween(T:GetSideLabel(1), x1, x2)

--
D1.below:LabelSide(2, "sinα", { align = true, text_offset = 20 })
D1.below:LabelSide(3, "cosα")

helpers.PutRotatedObjectBetween(D1.below:GetSideLabel(3), x1, x3)