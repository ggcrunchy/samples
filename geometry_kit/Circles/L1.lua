--- Circles, figure L-1.

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

--
local m1 = helpers.Mark(100, 150)
local m2 = helpers.Mark(170, 210)

--
local cx, cy = (m1.x + m2.x) / 2, (m1.y + m2.y) / 2
local dx, dy = cx - m1.x, cy - m1.y
local len = math.sqrt(dx^2 + dy^2)
local nx, ny = dy / len, -dx / len

--
local function Angle (mark, x, y)
	return math.deg(math.atan2(y - mark.y, mark.x - x))
end

for _, R in ipairs{ 150, 90 } do
	local ndist = math.sqrt(R^2 - len^2)
	local x, y = cx - nx * ndist, cy - ny * ndist
	local a1 = Angle(m2, x, y)
	local a2 = Angle(m1, x, y)

	--
	local C = arc.New()

	C:SetCenter(x, y)
	C:SetRadius(R)

	local L = C:Clone()

	C:SetAngles(a2, a1)
	L:SetAngles(a1, a2)
	L:SetStyle("dashed")

	nx, ny, m1, m2 = -nx, -ny, m2, m1
end

--
m1:toFront()
m2:toFront()