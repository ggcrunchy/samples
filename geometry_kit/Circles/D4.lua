--- Circles, figure D-1.

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
local D3 = require("Circles.D3")

--
D3.D1.above:Remove()
D3.D1.below:Remove()
D3.D1.A:Remove()
D3.T1:Remove()

for i = 1, 3 do
	D3.T2:SetSideStyle(i, nil)
end

--
D3.T2:Scale(1.7)
D3.T2:Translate(0, 100)
D3.T2:LabelAngle(2, "α", { radius = 64 })
D3.T2:LabelSide(2, "sinβ", { align = true })

--
local x2, y2 = D3.T2:GetVertexPos(2)
local x3, y3 = D3.T2:GetVertexPos(3)
local T = triangle.New()

T:SetVertexPos(1, x2, y3)
T:SetVertexPos(2, x2, y2)
T:SetVertexPos(3, x3, y3)

T:SetSideStyle(1, "hide")
T:SetSideStyle(2, "hide")
T:SetSideStyle(3, "dashed")
T:MarkAngle(1, 1, { angle_offset = .07 })

--
for i = 1, 2 do
	local mark = D3.D1.marks[i]

	mark.x, mark.y = D3.T2:GetVertexPos(i + 1)

	mark:toFront()
end