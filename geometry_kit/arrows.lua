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
local abs = math.abs
local unpack = unpack

-- Modules --
local math2d_ex = require("math2d_ex")
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

--
local function Begin (v1, v2, px, py, t, reverse, w)
	if reverse then
		v1, v2 = v2, v1
	end

	local sx, sy, nx, ny = px * w, py * w, side.GetPosOnSide(v1, v2, t)

	ArrowIndex, InReverse = 0, reverse

	AddArrowXY(v1.x, v1.y)
	AddArrowXY(nx, ny)
	AddArrowXY(nx + sx, ny + sy)

	return nx, ny, sx, sy -- "neck" point, side displacement
end

--
local function End (nx, ny, sx, sy)
	AddArrowXY(nx - sx, ny - sy)
	AddArrowXY(nx, ny)

	if InReverse then
		local correct = 1 - ArrowIndex

		for i = ArrowIndex, -1 do
			Arrow[i + correct], Arrow[i] = Arrow[i]
		end
	end

	return unpack(Arrow, 1, abs(ArrowIndex))
end

--- DOCME
function M.GetPoints (v1, v2, px, py, t, reverse)
	local nx, ny, sx, sy = Begin(v1, v2, px, py, t, reverse, 15)

	if reverse then
		v1, v2 = v2, v1
	end

	AddArrowXY(v2.x, v2.y)

	return End(nx, ny, sx, sy)
end

-- --
local W = 10 -- should be even

--- DOCME
function M.GetPointsFilled (v1, v2, px, py, t, reverse)
	local nx, ny, sx, sy = Begin(v1, v2, px, py, t, reverse, W)
	local nbins, diagx, diagy = W - 1, nx + sx, ny + sy

	if reverse then
		v1, v2 = v2, v1
	end

	local rx, ry, drx, dry, ddx, ddy = diagx, diagy, -sx / nbins, -sy / nbins, (v2.x - diagx) / nbins, (v2.y - diagy) / nbins

	for i = 1, 2 * nbins - 1 do
		-- At midpoint, "up" becomes down.
		if i == nbins + 1 then
			ddx, ddy = math2d_ex.Reflect(ddx, ddy, drx, dry)
		end

		diagx, rx = diagx + ddx, rx + drx
		diagy, ry = diagy + ddy, ry + dry

		if i % 2 == 0 then
			AddArrowXY(diagx, diagy)
			AddArrowXY(rx, ry)
		else
			AddArrowXY(rx, ry)
			AddArrowXY(diagx, diagy)
		end
	end

	return End(nx, ny, sx, sy)
end

-- Export the module.
return M