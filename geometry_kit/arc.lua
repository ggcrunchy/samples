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
local atan2 = math.atan2
local cos = math.cos
local deg = math.deg
local floor = math.floor
local pi = math.pi
local rad = math.rad
local setmetatable = setmetatable
local sin = math.sin

-- Plugins --
local math2d = require "plugin.math2d"

-- Kernels --
require("kernels")

-- Corona globals --
local display = display

-- Cached module references --
local _New_

-- Exports --
local M = {}

-- 
local Arc = {}

Arc.__index = Arc

--- DOCME
function Arc:Clone (into)
	local clone = _New_(into)

	clone:SetAngles(-self.m_to, -self.m_from)
	clone:SetCenter(self:GetCenter())
	clone:SetRadius(self:GetRadius())

	clone.m_circ.stroke.effect.spacing = self.m_circ.stroke.effect.spacing

	return clone
end

--- DOCME
function Arc:CosSin ()
	local angle = self:GetAngle_Radians()

	return cos(angle), sin(angle)
end

--- DOCME
function Arc:CosSin_R ()
	local radius, cosa, sina = self:GetRadius(), self:CosSin()

	return radius * cosa, radius * sina
end

--- DOCME
function Arc:GetAngle (great_arc)
	local from, to = self.m_from, self.m_to

	if to < from then
		to = to + 360
	end

	local angle = to - from

	return great_arc and 360 - angle or angle
end

--- DOCME
function Arc:GetAngle_Radians (great_arc)
	return rad(self:GetAngle(great_arc))
end

--- DOCME
function Arc:GetCenter ()
	local circ = self.m_circ

	return circ.x, circ.y
end

--- DOCME
function Arc:GetLength (great_arc)
	return self:GetAngle_Radians(great_arc) * self:GetRadius()
end

--
local function CosSinAtT (A, t)
	local from, to = A.m_from, A.m_to

	if to < from then
		to = to + 360
	end

	local angle = rad(from + t * (to - from))

	return cos(angle), sin(angle)
end

--- DOCME
function Arc:GetAngleFromPos (x, y)
	local cx, cy = self:GetCenter()

	x, y = x - cx, y - cy

	if x^2 + y^2 < 1e-12 then
		return 0
	else
		return deg(atan2(-y, x)) % 360
	end
end

--- DOCME
function Arc:GetPos (t)
	local circ, cosa, sina = self.m_circ, CosSinAtT(self, t)
	local radius = circ.path.radius

	return circ.x + floor(radius * cosa + .5), circ.y + floor(radius * sina + .5)
end

--- DOCME
function Arc:GetRadius ()
	return self.m_circ.path.radius
end

--- DOCME
function Arc:GetTangent (t)
	local cosa, sina = CosSinAtT(self, t)

	return sina, -cosa
end

--- Destroy the arc.
function Arc:Remove ()
	display.remove(self.m_group)

	self.m_object_group = nil
end

--- DOCME
function Arc:Revolve (triangle, center_index, through_index)
	local cx, cy = triangle:GetVertexPos(center_index or 1)
	local px, py = triangle:GetVertexPos(through_index or 2)

	self:SetCenter(cx, cy)
	self:SetRadius(math2d.length(px - cx, py - cy))
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
function Arc:Translate (dx, dy)
	local cx, cy = self:GetCenter()

	self:SetCenter(cx + dx, cy + dy)
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

-- Cache module members.
_New_ = M.New

-- Export the module.
return M