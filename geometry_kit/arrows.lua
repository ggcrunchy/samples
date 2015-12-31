--- Arrow-drawing utilities.

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

-- Standard library imports --
local unpack = unpack

-- Modules --
local side = require("side")

-- Exports --
local M = {}

-- --
local Arrow = {}

--
local ArrowIndex, InReverse

--
local function AddArrowXY (x, y)
	if InReverse then
		Arrow[ArrowIndex - 2], Arrow[ArrowIndex - 1] = x, y
		ArrowIndex = ArrowIndex - 2
	else
		Arrow[ArrowIndex + 1], Arrow[ArrowIndex + 2] = x, y
		ArrowIndex = ArrowIndex + 2
	end
end

--- DOCME
function M.GetPoints (v1, v2, px, py, t, reverse)
	if reverse then
		v1, v2 = v2, v1
	end

	local neck_x, neck_y = side.GetPosOnSide(v1, v2, t)

	ArrowIndex, InReverse = 0, reverse

	AddArrowXY(v1.x, v1.y)
	AddArrowXY(neck_x, neck_y)
	AddArrowXY(neck_x + px * 15, neck_y + py * 15)
	AddArrowXY(v2.x, v2.y)
	AddArrowXY(neck_x - px * 15, neck_y - py * 15)
	AddArrowXY(neck_x, neck_y)

	if InReverse then
		local correct = 1 - ArrowIndex

		for i = ArrowIndex, -1 do
			Arrow[i + correct], Arrow[i] = Arrow[i]
		end
	end

	return unpack(Arrow)
end

-- Export the module.
return M