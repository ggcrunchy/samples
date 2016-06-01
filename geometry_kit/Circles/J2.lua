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
local A, CX, CY = arc.New(), 160, 200

A:SetCenter(CX, CY)
A:SetRadius(110)
A:SetAngles(0, 180)
A:SetStyle("dashed")

--
for i = 1, 3 do
	local x1, y1 = A:GetPos((i - 1) / 3)
	local x2, y2 = A:GetPos(i / 3)
	local T = triangle.New()

	T:SetVertexPos(1, x1, y1)
	T:SetVertexPos(2, x2, y2)
	T:SetVertexPos(3, CX, CY)

	--
	for j = 1, 3 do
		T:MarkAngle(j, 1, { angle_offset = .2 })

		if i == 1 or j < 3 then
			T:MarkSide(j, 1)
		end
	end
end

--
for i = 1, 3 do
	if i == 1 then
		helpers.Mark(A:GetPos((i - 1) / 3))
	end

	helpers.Mark(A:GetPos(i / 3))
end