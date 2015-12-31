--- Utilities for drawing angles of shapes.

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
local acos = math.acos
local cos = math.cos
local setmetatable = setmetatable
local sin = math.sin

-- Plugins --
local math2d = require "plugin.math2d"

-- Exports --
local M = {}

-- --
local Frame = {}

Frame.__index = Frame

--- DOCME
function Frame:GetPosAtParameter (t)
	local angle, radius, x, y = self.m_angle * t, self.m_radius or 1, self.m_x or 0, self.m_y or 0
	local dx, dy = radius * cos(angle), radius * sin(angle)

	return x + dx * self.m_xx + dy * self.m_yx, y + dx * self.m_xy + dy * self.m_yy
end

--- DOCME
function Frame:SetPosition (x, y)
	self.m_x, self.m_y = x, y
end

--- DOCME
function Frame:SetRadius (radius)
	self.m_radius = radius
end

--- DOCME
function M.GetAxes (vprev, vcur, vnext)
	local vx, vy = math2d.diff(vcur, vprev, true)
	local wx, wy = math2d.diff(vcur, vnext, true)
	local offset = math2d.dot(vx, vy, wx, wy) / math2d.length2(wx, wy)
	local dx, dy = wx * offset, wy * offset

	wx, wy = math2d.normalize(wx, wy)

	local cos_vw, frame = math2d.dot(vx, vy, wx, wy) / math2d.length(vx, vy), {}

	frame.m_angle = acos(cos_vw)
	frame.m_xx, frame.m_xy = wx, wy
	frame.m_yx, frame.m_yy = math2d.normalize(math2d.sub(vx, vy, dx, dy))

	return setmetatable(frame, Frame)
end

-- Export the module.
return M