--- Arc class.

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
local deg = math.deg
local floor = math.floor
local pi = math.pi
local setmetatable = setmetatable

-- Kernels --
require("kernels")

-- Corona globals --
local display = display

-- Exports --
local M = {}

-- 
local Arc = {}

Arc.__index = Arc

--- Destroy the arc.
function Arc:Remove ()
	display.remove(self.m_group)

	self.m_object_group = nil
end

--- DOCME
function Arc:GetCenter ()
	local circ = self.m_circ

	return circ.x, circ.y
end

--- DOCME
function Arc:GetRadius ()
	return self.m_circ.path.radius
end

--- DOCME
function Arc:SetAngles (from, to)
	from, to = -to % 360, -from % 360 -- make these use common mathematical layout

	self.m_from, self.m_to = from, to

	local effect = self.m_circ.stroke.effect

	effect.angles = floor(from * 255 / 360) + floor(to * 255 / 360) * 256
end

--- DOCME
function Arc:SetAngles_Radians (from, to)
	self:SetAngles(deg(from), deg(to))
end

--- DOCME
function Arc:SetCenter (cx, cy)
	local circ = self.m_circ

	circ.x, circ.y = cx, cy

	circ.stroke.effect.cx = cx
	circ.stroke.effect.cy = cy
end

--- DOCME
function Arc:SetRadius (radius)
	self.m_circ.path.radius = radius
end

--- DOCME
function Arc:SetStyle (style)
	if style == "hide" then
		self.m_group.isVisible = false
	elseif style == "dashed" or style == "normal" then
		self.m_group.isVisible = true

		self.m_circ.stroke.effect.spacing = style == "normal" and 4 * pi or pi / 50
	end
end

--- DOCME
function M.New (into)
	into = into or display.getCurrentStage()

	local group = display.newGroup()

	into:insert(group)

	local circ = display.newCircle(group, 0, 0, 1)

	circ:setFillColor(0, 0)
	circ:setStrokeColor(0)

	circ.stroke.effect = "filter.geometry_kit.arc_dashes"
	circ.strokeWidth = 3

	return setmetatable({
		m_circ = circ,
		m_from = 0, m_to = 360,
		m_group = group
	}, Arc)
end

-- Export the module.
return M