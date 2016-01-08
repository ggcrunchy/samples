--- Some operations built up from math2d stuff.

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
local asin = math.asin
local pi = math.pi

-- Plugins --
local math2d = require "plugin.math2d"

-- Exports --
local M = {}

--- DOCME
-- See also [The Right Way To Calculate Stuff](, http://www.plunk.org/~hatch/rightway.php), "angle between unit vectors". 
function M.AngleBetweenUnitVectors (vx, vy, wx, wy)
	local neg = math2d.dot(vx, vy, wx, wy) < 0
	local dx, dy = math2d.sub(wx, wy, vx, vy)
	local angle = 2 * asin(math2d.length(dx, dy) / 2)

	return neg and pi - angle or angle
end

--- DOCME
function M.ProjectOnto (vx, vy, wx, wy, how)
	local offset = math2d.dot(vx, vy, wx, wy) / math2d.length2(wx, wy)
	local px, py = wx * offset, wy * offset

	if how == "rejection" or how == "both" then
		local rx, ry = math2d.normalize(math2d.sub(vx, vy, px, py))

		if how == "both" then
			return px, py, rx, ry
		else
			return rx, ry
		end
	else
		return px, py
	end
end

-- Export the module.
return M