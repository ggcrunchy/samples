--- Triangles, figure B-1.

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
local ToLowerRightX = .6 * CW
local ToUpperRightX, ToUpperRightY = .3 * CW, -.15 * CH

local function TriAt (x, y)
	local T = triangle.New()

	T:SetVertexPos(1, x, y)
	T:SetVertexPos(2, x + ToUpperRightX, y + ToUpperRightY)
	T:SetVertexPos(3, x + ToLowerRightX, y)
	T:SetSideStyle(2, "hide")

	return T
end

--
local T = TriAt(.1 * CW, .45 * CH)
local x0, y0 = .3 * CW, .7 * CH

local function GetXY (s)
	return x0 + s * ToUpperRightX + (1 - s) * ToLowerRightX, y0 + s * ToUpperRightY
end

for i = 1, 3 do
	local u = TriAt(x0, y0)

	u:SetVertexPos(2, GetXY(1 - (i - 1) / 3))
	u:SetVertexPos(3, GetXY(1 - i / 3))
	u:MarkAngle(1, i, { angle_offset = .7 })
end