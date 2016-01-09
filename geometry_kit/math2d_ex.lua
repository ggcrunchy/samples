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
local type = type

-- Plugins --
local math2d = require "plugin.math2d"

-- Exports --
local M = {}

--- DOCME
function M.AddScaled (a, b, c, d, e) -- TODO: altRets?
	--
	if type(a) == "table" then -- a = { x = v.x, y = v.y }
		if type(b) == "table" then -- b = { x = w.x, y = w.y }, c = scale
			return math2d.add(a, math2d.scale(b, c))
		else -- b = w.x, c = w.y, d = scale
			return math2d.add(a.x, a.y, math2d.scale(b, c, d))
		end
	elseif type(b) == "table" then -- a = v.x, b = v.y, c = { x = w.x, y = w.y }, d = scale
		return math2d.add(a, b, math2d.scale(c.x, c.y, d))
	else -- a = v.x, b = v.y, c = w.x, d = w.y, e = scale
		return math2d.add(a, b, math2d.scale(c, d, e))
	end
end

--- DOCME
-- See also [The Right Way To Calculate Stuff](, http://www.plunk.org/~hatch/rightway.php), "angle between unit vectors". 
function M.AngleBetweenUnitVectors (vx, vy, wx, wy)
	local dx, dy = math2d.sub(wx, wy, vx, vy)

	return 2 * asin(math2d.length(dx, dy) / 2)
end

--- DOCME
function M.ProjectOnto (vx, vy, wx, wy, how)
	local offset = math2d.dot(vx, vy, wx, wy) / math2d.length2(wx, wy)
	local px, py = math2d.scale(wx, wy, offset)

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