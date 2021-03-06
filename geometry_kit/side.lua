--- Utilities for drawing sides of shapes.

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
local math2d_ex = require("math2d_ex")

-- Plugins --
local math2d = require "plugin.math2d"

-- Exports --
local M = {}

--- DOCME
function M.GetPosOnSide (v1, v2, t)
	local dx, dy = math2d.diff(v1, v2, true)

	return math2d_ex.AddScaled(v1, dx, dy, t)
end

--- DOCME
function M.Perp (v1, v2)
	return math2d.normals(math2d.normalize(math2d.sub(v1, v2, true)))
end

--- DOCME
function M.ProjectOpposite (c, p1, p2)
	local vx, vy = math2d.diff(p2, c, true)
	local wx, wy = math2d.diff(p1, p2, true)

	return math2d_ex.ProjectOnto(vx, vy, wx, wy)
end

-- Export the module.
return M