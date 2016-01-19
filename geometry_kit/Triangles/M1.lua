--- Triangles, figure M-1.

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
local LeftX = .025 * CW
local TopY = .1 * CH
local BottomY = .75 * CH

-- NOTE: use landscape for this one
local N = 6
local Width = CW / (N + .25 * (N + 1))

for i = 1, N do
	local T, t = triangle.New(), (i - 1) / (N - 1)
	local s = 1 - t

	T:SetVertexPos(1, LeftX, BottomY)
	T:SetVertexPos(2, LeftX + Width, s * TopY + t * BottomY)
	T:SetVertexPos(3, LeftX + Width, BottomY)

	T:MarkAngle(3, 1, { angle_offset = .25 - t * .125 })
	
	LeftX = LeftX + 1.25 * Width
end