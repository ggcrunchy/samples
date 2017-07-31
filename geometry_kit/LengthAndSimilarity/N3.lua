--- Triangles, figure N-3.

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
local figure28 = require("Triangles.N1")

-- --
local P, Q = figure28.P, figure28.Q
local BottomY, TopY = P.y, Q.y
local LeftX, RightX = P.x, Q.x

figure28.StrP:removeSelf()
figure28.StrQ:removeSelf()

--
local T = triangle.New()

T:SetVertexPos(1, LeftX, BottomY)
T:SetVertexPos(2, RightX, TopY)
T:SetVertexPos(3, RightX, BottomY)

local U = T:Clone()

U:Scale(.6)

local x, y = U:GetVertexPos(1)

U:Translate(LeftX - x, BottomY - y)
U:LabelSide(2, "s·dy", { text_offset = 35 })
U:LabelSide(3, "s·dx")
U:MarkAngle(3, 1, { angle_offset = .18 })

for i = 2, 3 do
	local x2, y2 = U:GetVertexPos(i)
	local mark = display.newCircle(x2, y2, 5)

	mark:setFillColor(.3)
	mark:setStrokeColor(0)

	mark.strokeWidth = 4
end

T:SetSideStyle(1, "dashed")
T:SetSideStyle(2, "dashed")
T:SetSideStyle(3, "dashed")

T:MarkAngle(3, 1)

-- TODO: second similar triangle, nodes