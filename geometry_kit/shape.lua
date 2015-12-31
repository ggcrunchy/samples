--- Base shape class.

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
local setmetatable = setmetatable

-- Modules --
local angle = require("angle")
local arrows = require("arrows")
local color = require("color")
local side = require("side")

-- Plugins --
local math2d = require "plugin.math2d"

-- Corona globals --
local display = display

-- Exports --
local M = {}

--
local Shape = {}

Shape.__index = Shape

--- Get a vertex's position.
-- @int vertex
-- @treturn number X
-- @treturn number Y
function Shape:GetVertexPos (vertex)
	local pos = self[vertex]

	return pos.x, pos.y
end

--
local function AwayFromSide (S, index)
	return side.Perp(S[index], S:GetNext(index))
end

--
local function GetNeighbors (S, index)
	return S:GetPrev(index), S:GetNext(index)
end

-- --
local Spacing = .05

--
local function RedrawAngleMarks (S, vprev, vcur, vnext, n)
	local marks, frame = vcur.m_angle_marks or {}, angle.GetAxes(vprev, vcur, vnext)
	local len = math2d.length(math2d.diff(vcur, vnext, true))

	frame:SetPosition(vcur.x, vcur.y)

	for i = 1, n do
		frame:SetRadius((.1 + (i - 1) * Spacing) * len)

		local x1, y1 = frame:GetPosAtParameter(0)
		local x2, y2 = frame:GetPosAtParameter(.1)

		marks[i] = display.newLine(S.m_mark_group, x1, y1, x2, y2)

		for j = 2, 10 do
			marks[i]:append(frame:GetPosAtParameter(j / 10))
		end

		marks[i].strokeWidth = 3
	end

	vcur.m_angle_marks = marks
end

--
local function RedrawSideMarks (S, vcur, vnext, n)
	local marks, dx, dy = vcur.m_side_marks or {}, side.Perp(vcur, vnext)
	local start = (1 - n * Spacing) / 2

	for i = 1, n do
		local x, y = side.GetPosOnSide(vcur, vnext, start + (i - 1) * Spacing)

		marks[i] = display.newLine(S.m_mark_group, x - dx * 10, y - dy * 10, x + dx * 10, y + dy * 10)

		marks[i].strokeWidth = 3
	end

	vcur.m_side_marks = marks
end

--
local function GetOrRemoveLabel (S, index, name, label)
	local v = S[index]

	if not label then
		display.remove(v[name])

		v[name] = nil
	else
		local cur = v[name]

		if label ~= true then -- true: reuse as is
			if not cur then
				cur = display.newText(S.m_mark_group, label, 0, 0, native.systemFont, 24)

				v[name] = cur
			elseif cur.text ~= label then
				cur.text = label
			end
		end

		return v, cur
	end
end

--
local function UpdateAngleLabel (S, index, label)
	local apos, text = GetOrRemoveLabel(S, index, "m_angle_label", label)

	if text then
		local vprev, vnext = GetNeighbors(S, index)
		local frame = angle.GetAxes(vprev, S[index], vnext)

		frame:SetRadius(35)
		frame:SetPosition(apos.x, apos.y)

		text.x, text.y = frame:GetPosAtParameter(.5)
	end
end

--- Add or remove a label to / from an angle.
-- @int angle_index
-- @tparam ?|string|nil label
-- @table[opt] props
function Shape:LabelAngle (angle_index, label, props)
	-- props

	UpdateAngleLabel(self, angle_index, label)
end

--
local function UpdateSideLabel (S, index, label)
	local side, text = GetOrRemoveLabel(S, index, "m_side_label", label)

	if text then
		local next = S:GetNext(index)
		local x, y = side.GetPosOnSide(side, next, .5) -- TODO: t
		local dx, dy = AwayFromSide(S, index)

		text.x, text.y = x + dx * 30, y + dy * 30
	end
end

--- Add or remove a label to / from a side.
-- @int side_index
-- @tparam ?|string|nil label
-- @table[opt] props
function Shape:LabelSide (side_index, label, props)
	-- props

	UpdateSideLabel(self, side_index, label)
end

--
local function RemoveMarks (marks)
	local n = #(marks or "")

	for i = 1, n do
		marks[i]:removeSelf()

		marks[i] = nil
	end

	return n
end

--- Add or remove markings to / from an angle.
-- @int angle_index
-- @int[opt=0] count
-- @table[opt] props
function Shape:MarkAngle (angle_index, count, props)
	local angle = self[angle_index]

	RemoveMarks(angle.m_angle_marks)

	if count and count > 0 then
		--
		if props then
			-- offset, spacing
		end

		RedrawAngleMarks(self, self:GetPrev(angle_index), angle, self:GetNext(angle_index), count)
	else
		angle.m_angle_marks = nil
	end
end

--- Add or remove markings to / from a side.
-- @int side_index
-- @int[opt=0] count
-- @table[opt] props
function Shape:MarkSide (side_index, count, props)
	local side = self[side_index]

	RemoveMarks(side.m_side_marks)

	if count and count > 0 then
		--
		if props then
			-- offset, spacing
		end

		RedrawSideMarks(self, side, self:GetNext(side_index), count)
	else
		side.m_side_marks = nil
	end
end

--- Destroy the triangle.
function Shape:Remove ()
	display.remove(self.m_object_group)

	self.m_object_group = nil
end

--- DOCME
-- @int angle_index
-- @param ...
function Shape:SetAngleLabelColor (angle_index, ...)
	color.SetThenApply(self, angle_index, "m_angle_label", "m_angle_label_color", ...)
end

--- DOCME
-- @int angle_index
-- @param ...
function Shape:SetAngleMarkColor (angle_index, ...)
	color.SetThenApplyToArray(self, angle_index, "m_angle_marks", "m_angle_mark_color", ...)
end

--- DOCME
-- @int side_index
-- @param ...
function Shape:SetSideLabelColor (side_index, ...)
	color.SetThenApply(self, side_index, "m_side_label", "m_side_label_color", ...)
end

--- DOCME
-- @int side_index
-- @param ...
function Shape:SetSideMarkColor (side_index, ...)
	color.SetThenApplyToArray(self, side_index, "m_side_marks", "m_side_mark_color", ...)
end

--
local function RedrawSide (S, index)
	--
	UpdateAngleLabel(S, index, true)
	UpdateSideLabel(S, index, true)

	--
	local v1, v2 = S[index], S:GetNext(index)
	local nam = RemoveMarks(v1.m_angle_marks)
	local nas = RemoveMarks(v1.m_side_marks)

	--
	if nam > 0 then
		RedrawAngleMarks(S, S:GetPrev(index), v1, v2, nam)
	end

	--
	if nas > 0 then
		RedrawSideMarks(S, v1, v2, nas)
	end

	--
	display.remove(v1.m_object)

	--
	local style, px, py = v1.m_style, AwayFromSide(S, index)

	if style == "a_to_b" or style == "b_to_a" then
		v1.m_object = display.newLine(S.m_side_group, arrows.GetPoints(v1, v2, px, py, .9, style == "b_to_a"))
	else
		v1.m_object = display.newLine(S.m_side_group, v1.x, v1.y, v2.x, v2.y)

		if style == "dashed" then
			--
		end
	end

	--
	-- TODO: If offset, push side away by offset * px,py

	v1.m_object.strokeWidth = 5

	color.ApplyColor(v1.m_object, "m_color", v1, v2)
end

--- DOCME
-- @int side_index
-- @number[opt] offset
function Shape:SetSideOffset (side_index, offset)
	if self[side_index].m_offset ~= offset then
		self[side_index].m_offset = offset

		RedrawSide(self, side_index)
	end
end

--- DOCME
-- @int side_index
-- @string[opt="normal"] style
function Shape:SetSideStyle (side_index, style)
	if style ~= "a_to_b" and style ~= "b_to_a" then
		style = "normal"
	end

	if self[side_index].m_style ~= style then
		self[side_index].m_style = style

		RedrawSide(self, side_index)
	end
end

--- DOCME
-- @int vertex_index
-- @param ...
function Shape:SetVertexColor (vertex_index, ...)
	color.SetThenApply(self, vertex_index, "m_object", "m_color", ...)
end

--- DOCME
-- @int vertex_index
-- @number x
-- @number y
function Shape:SetVertexPos (vertex_index, x, y)
	local vprev, vnext = GetNeighbors(self, vertex_index)

	--
	local vcur = self[vertex_index] or {}

	vcur.x, vcur.y = x, y

	self[vertex_index] = vcur

	--
	if vprev then
		RedrawSide(self, self:PrevIndex(vertex_index))
	end

	if vnext then
		RedrawSide(self, vertex_index)
	end
end

--- DOCME
function M.Inherit ()
	local mt = setmetatable({}, Shape)

	mt.__index = mt

	return mt
end

--- DOCME
function M.NewShape (into, mt)
	into = into or display.getCurrentStage()

	local object_group = display.newGroup()
	local mark_group = display.newGroup()
	local side_group = display.newGroup()

	object_group:insert(mark_group)
	object_group:insert(side_group)
	into:insert(object_group)

	return setmetatable({
		m_mark_group = mark_group,
		m_side_group = side_group,
		m_object_group = object_group
	}, mt)
end

-- Export the module.
return M