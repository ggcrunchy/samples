--- Circles, figure D-3.

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
local D1 = require("AddingAngles.A1")

--
D1.above:LabelAngle(1, nil)
D1.above:LabelSide(2, nil)
D1.below:LabelAngle(1, nil)
D1.below:MarkAngle(3, nil)

--
local x1, y1 = D1.below:GetVertexPos(1)
local x2, y2 = D1.below:GetVertexPos(2)
local x3, y3 = D1.above:GetVertexPos(2)

--
local x4, y4 = x3, y1 + (x3 - x1) * (y2 - y1) / (x2 - x1)

--
local T1 = triangle.New()

T1:SetVertexPos(1, x1, y1)
T1:SetVertexPos(2, x4, y4)
T1:SetVertexPos(3, x4, y1)

T1:MarkAngle(2, 2, { angle_offset = .3, angle_spacing = .2 })
T1:MarkAngle(3, 1, { angle_offset = .15 })

T1:SetSideStyle(1, "hide")
T1:SetSideStyle(2, "dashed")
T1:SetSideStyle(3, "hide")

--
local T2 = triangle.New()

T2:SetVertexPos(1, x4, y4)
T2:SetVertexPos(2, x3, y3)
T2:SetVertexPos(3, D1.above:GetVertexPos(3))

T2:MarkAngle(1, 2)
T2:MarkAngle(2, 1, { angle_offset = .2 })
T2:SetSideStyle(1, "dashed")
T2:SetSideStyle(2, "hide")
T2:SetSideStyle(3, "hide")

return { D1 = D1, T1 = T1, T2 = T2 }