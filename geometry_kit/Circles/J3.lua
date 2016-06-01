--- Circles, figure J-2.

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
local helpers = require("helpers")
local triangle = require("triangle")

--
local A, CX, CY = arc.New(), 160, 250

A:SetCenter(CX, CY)
A:SetRadius(190)
A:SetAngles(60, 120)
A:SetStyle("dashed")

--
local T, x1, y1 = triangle.New(), A:GetPos(0)

T:SetVertexPos(1, CX, CY)
T:SetVertexPos(2, x1, y1)
T:SetVertexPos(3, A:GetPos(1))

for i = 1, 3 do
	T:MarkAngle(i, i == 1 and 2, { angle_offset = .2 })
end

T:SetSideStyle(2, "dashed")

--
local U = triangle.New()

U:SetVertexPos(1, T:GetVertexPos(2))
U:SetVertexPos(2, CX, y1)
U:SetVertexPos(3, CX, CY)

for i = 1, 3 do
	U:SetSideStyle(i, "hide")
end

U:MarkAngle(2, 1)

--
local N1, N2 = triangle.New(), triangle.New()

N1:SetVertexPos(1, x1, y1)
N1:SetVertexPos(2, A:GetPos(.5))
N1:SetVertexPos(3, CX, CY)

N2:SetVertexPos(1, A:GetPos(.5))
N2:SetVertexPos(2, A:GetPos(1))
N2:SetVertexPos(3, CX, CY)

N2:SetSideStyle(3, "hide")

for i = 1, 2 do
	local props = { angle_offset = .03 + (3 - i) * .09 }

	N1:MarkAngle(i, 1, props)
	N2:MarkAngle(i, 1, props)
	N1:MarkSide(i + 1, i > 1 and 1)
	N2:MarkSide(i + 1, 1)
end