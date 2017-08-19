--- Similar triangles, figure D-6.

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

--
local x, y, h = 190, 200, 90
local DXL, DXR = 150, 80

--
local UL = triangle.New()

UL:SetVertexPos(1, x - DXL, y)
UL:SetVertexPos(2, x + .5, y - h)
UL:SetVertexPos(3, x + .5, y)

UL:MarkAngle(2, 1, { angle_offset = .275 })
UL:MarkAngle(3, 2)
UL:MarkSide(1, 1)
UL:SetSideStyle(2, "dashed")
UL:SetSideStyle(3, "dashed")

--
local UR = triangle.New()

UR:SetVertexPos(1, UL:GetVertexPos(3))
UR:SetVertexPos(2, UL:GetVertexPos(2))
UR:SetVertexPos(3, x + DXR, y)

UR:MarkAngle(2, 2, { angle_offset = .2, angle_spacing = .075 })
UR:MarkSide(2, 2)
UR:SetSideStyle(1, "hide")
UR:SetSideStyle(3, "dashed")

--
local LL = triangle.New()

LL:SetVertexPos(1, UL:GetVertexPos(1))
LL:SetVertexPos(2, UL:GetVertexPos(3))
LL:SetVertexPos(3, x + .5, y + h)

LL:MarkAngle(3, 1, { angle_offset = .15 })
LL:MarkSide(3, 1)
LL:SetSideStyle(1, "hide")
LL:SetSideStyle(2, "dashed")

--
local LR = triangle.New()

LR:SetVertexPos(1, LL:GetVertexPos(2))
LR:SetVertexPos(2, UR:GetVertexPos(3))
LR:SetVertexPos(3, LL:GetVertexPos(3))

LR:MarkAngle(3, 2, { angle_offset = .275, angle_spacing = .075 })
LR:MarkSide(2, 2)
LR:SetSideStyle(1, "hide")
LR:SetSideStyle(3, "hide")