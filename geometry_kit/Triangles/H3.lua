--- Triangles, figure H-3.

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

-- --
local CW, CH = display.contentWidth, display.contentHeight

-- --
local X = .4 * CW
local Y = .25 * CW

--
local BottomY, BottomLeftX = .5 * CH, .5 * CW
local LeftX, TopY = .15 * CW, .15 * CH

--
local T = triangle.New()

T:SetVertexPos(1, LeftX, TopY)
T:SetVertexPos(2, LeftX + X, TopY)
T:SetVertexPos(3, LeftX, TopY + Y)

T:SetSideStyle(2, "hide")
T:MarkAngle(1, 1, { angle_offset = .15 })

local cur = T

for i = 1, 2 do
	local new = cur:Clone()

	new:Rotate(90)

	local x2, y2 = cur:GetVertexPos(2)

	if i < 2 then
		local x1, y1 = new:GetVertexPos(3)

		new:Translate(x2 - x1, y2 - y1)

		cur = new
	else
		new:Remove()
	end
end

local Right = triangle.New()

local x3, y3 = cur:GetVertexPos(1)

Right:SetVertexPos(1, x3, y3)
Right:SetVertexPos(2, x3 + 40, y3)
Right:SetVertexPos(3, x3, y3 + 100)

Right:SetSideStyle(2, "hide")
Right:MarkAngle(1, 1, { angle_offset = .5 })