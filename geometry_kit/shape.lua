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
local atan2 = math.atan2
local cos = math.cos
local deg = math.deg
local getmetatable = getmetatable
local pairs = pairs
local rad = math.rad
local setmetatable = setmetatable
local sin = math.sin
local sqrt = math.sqrt
local type = type

-- Modules --
local angle = require("angle")
local arrows = require("arrows")
local color = require("color")
local side = require("side")

-- Kernels --
require("kernels")

-- Plugins --
local math2d = require "plugin.math2d"

-- Corona globals --
local display = display
local graphics = graphics
local native = native

-- Cached module references --
local _NewShape_

-- Exports --
local M = {}

--
local Shape = {}

Shape.__index = Shape

--- DOCME
function Shape:Centroid ()
	local cx, cy, n = 0, 0, self.m_n

	--
	for i = 1, n do
		local px, py = self:GetVertexPos(i)

		cx, cy = cx + px, cy + py
	end

	return cx / n, cy / n
end

--
local function AuxClone (into, from)
	for k, v in pairs(from) do
		if not into[k] then
			if type(v) == "table" then -- n.b. assumes no cycles!
				if v._proxy then
					into[k] = v.text -- display object, might have text
				elseif k == "m_angle_marks" or k == "m_side_marks" then
					into[k] = #v
				else
					into[k] = {}

					AuxClone(into[k], v)
				end
			else
				into[k] = v
			end
		end
	end
end

--
local function Refresh (S, n)
	for i = 1, n do
		S:SetVertexPos(i, S:GetVertexPos(i)) -- invoke redraws
	end
end

--- DOCME
function Shape:Clone (into)
	local clone = _NewShape_(into, getmetatable(self))

	AuxClone(clone, self)
	Refresh(clone, clone.m_n)

	return clone
end

--
local function AuxGetLabel (S, index, lkey)
	local v = S[index]
	local label = v[lkey]

	return type(label) ~= "string" and label
end

--- DOCME
function Shape:GetAngleLabel (index)
	return AuxGetLabel(self, index, "m_angle_label")
end

--
local function NextIndex (S, index)
	return (index % S.m_n) + 1
end

--
local function PrevIndex (S, index)
	local n = S.m_n
	local m = n - 2

	return (index + m) % n + 1
end

--- DOCME
function Shape:GetPrev (index)
	return self[PrevIndex(self, index)]
end

--- DOCME
function Shape:GetNext (index)
	return self[NextIndex(self, index)]
end

--- DOCME
function Shape:GetSideLabel (index)
	return AuxGetLabel(self, index, "m_side_label")
end

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
local Props = {}

--
local function NewProp (name, def)
	Props[name] = { key = "m_" .. name, def = def }
end

--
local function GetSetOpt (from, name, opts)
	local v, prop = opts and opts[name], Props[name]
-- TODO: Argh! (something's wrong when it's already there...)
	if v == nil then
		v = from[prop.key]

		if v == nil then
			v = prop.def
		end
	else
		from[prop.key] = v
	end

	return v
end

--
NewProp("angle_offset", .1)
NewProp("angle_resolution", 10)
NewProp("angle_spacing", .05)
NewProp("no_right_angles", false)

--
local function RedrawAngleMarks (S, vprev, vcur, vnext, n, opts)
	local marks, frame = vcur.m_angle_marks or {}, angle.GetAxes(vprev, vcur, vnext)
	local len, offset = math2d.length(math2d.diff(vcur, vnext, true)), GetSetOpt(vcur, "angle_offset", opts)

	frame:SetPosition(vcur.x, vcur.y)

	if frame:IsRight() and not GetSetOpt(vcur, "no_right_angles", opts) then
		frame:SetRadius(offset * len)

		local x1, y1 = frame:GetPosAtParameter(0)
		local x2, y2 = frame:Map(1, 1)
		local x3, y3 = frame:GetPosAtParameter(1)

		marks[1] = display.newLine(S.m_mark_group, x1, y1, x2, y2, x3, y3)

		marks[1]:setStrokeColor(0)

		marks[1].strokeWidth = 3
	else
		local spacing, nangle = GetSetOpt(vcur, "angle_spacing", opts), GetSetOpt(vcur, "angle_resolution", opts)

		for i = 1, n do
			frame:SetRadius((offset + (i - 1) * spacing) * len)

			local x1, y1 = frame:GetPosAtParameter(0)
			local x2, y2 = frame:GetPosAtParameter(1 / nangle)

			marks[i] = display.newLine(S.m_mark_group, x1, y1, x2, y2)

			marks[i]:setStrokeColor(0)

			for j = 2, nangle do -- todo: parametrize
				marks[i]:append(frame:GetPosAtParameter(j / nangle))
			end

			marks[i].strokeWidth = 3
		end
	end

	vcur.m_angle_marks = marks
end

--
NewProp("font", native.systemFontBold)
NewProp("side_mark_length", 20)
NewProp("size", 24)

--
local function RedrawSideMarks (S, vcur, vnext, n, opts)
	local marks, dx, dy = vcur.m_side_marks or {}, side.Perp(vcur, vnext)
	local spacing = GetSetOpt(vcur, "angle_spacing", opts)
	local start = (1 - n * spacing) / 2 -- todo: parametrize
	local len = GetSetOpt(vcur, "side_mark_length", opts) / 2

	for i = 1, n do
		local x, y = side.GetPosOnSide(vcur, vnext, start + (i - 1) * spacing)

		marks[i] = display.newLine(S.m_mark_group, x - dx * len, y - dy * len, x + dx * len, y + dy * len)

		marks[i]:setStrokeColor(0)

		marks[i].strokeWidth = 3
	end

	vcur.m_side_marks = marks
end

--
NewProp("font", native.systemFontBold)
NewProp("size", 24)

--
local function GetOrRemoveLabel (S, index, name, label, opts)
	local v = S[index]
	local cur = v[name]

	if type(cur) == "string" then -- text pending?
		label, cur = cur
	end

	if not label then
		display.remove(cur)

		v[name] = nil
	else
		if label ~= true then -- true: reuse as is
			if not cur then
				cur = display.newText(S.m_mark_group, label, 0, 0, GetSetOpt(v, "font", opts), GetSetOpt(v, "size", opts))

				cur:setFillColor(0)

				v[name] = cur
			elseif cur.text ~= label then
				cur.text = label
			end
		end

		return v, cur
	end
end

--
NewProp("radius", 35)
NewProp("angle_time", .5)

--
local function UpdateAngleLabel (S, index, label, opts)
	local apos, text = GetOrRemoveLabel(S, index, "m_angle_label", label, opts)

	if text then
		local vprev, vnext = GetNeighbors(S, index)
		local frame = angle.GetAxes(vprev, S[index], vnext)

		frame:SetRadius(GetSetOpt(apos, "radius", opts))
		frame:SetPosition(apos.x, apos.y)

		text.x, text.y = frame:GetPosAtParameter(GetSetOpt(apos, "angle_time", opts))
	end
end

--- Add or remove a label to / from an angle.
-- @int angle_index
-- @tparam ?|string|nil label
-- @table[opt] props
function Shape:LabelAngle (angle_index, label, props)
	UpdateAngleLabel(self, angle_index, label, props)
end

--
NewProp("t", .5)
NewProp("text_offset", 25)
NewProp("align", false)

--
local function UpdateSideLabel (S, index, label, opts)
	local cur, text = GetOrRemoveLabel(S, index, "m_side_label", label)

	if text then
		local next = S:GetNext(index)
		local x, y = side.GetPosOnSide(cur, next, GetSetOpt(cur, "t", opts))
		local offset, dx, dy = GetSetOpt(cur, "text_offset", opts), AwayFromSide(S, index)

		text.x, text.y = x + dx * offset, y + dy * offset

		if GetSetOpt(cur, "align", opts) then
			text.rotation = deg(atan2(dy, dx)) + 90
		end
	end
end

--- Add or remove a label to / from a side.
-- @int side_index
-- @tparam ?|string|nil label
-- @table[opt] props
function Shape:LabelSide (side_index, label, props)
	UpdateSideLabel(self, side_index, label, props)
end

--
local function RemoveMarks (S, mkey)
	local marks = S[mkey]

	if type(marks) == "number" then
		S[mkey] = nil

		return marks
	else
		local n = #(marks or "")

		for i = 1, n do
			marks[i]:removeSelf()

			marks[i] = nil
		end

		return n
	end
end

--- Add or remove markings to / from an angle.
-- @int angle_index
-- @int[opt=0] count
-- @table[opt] props
function Shape:MarkAngle (angle_index, count, props)
	local angle = self[angle_index]

	RemoveMarks(angle, "m_angle_marks")

	if count and count > 0 then
		RedrawAngleMarks(self, self:GetPrev(angle_index), angle, self:GetNext(angle_index), count, props)
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

	RemoveMarks(side, "m_side_marks")

	if count and count > 0 then
		RedrawSideMarks(self, side, self:GetNext(side_index), count, props)
	else
		side.m_side_marks = nil
	end
end

--- DOCME
Shape.NextIndex = NextIndex

--- DOCME
Shape.PrevIndex = PrevIndex

--- Destroy the triangle.
function Shape:Remove ()
	display.remove(self.m_object_group)

	self.m_object_group = nil
end

--- DOCME
function Shape:Rotate (delta)
	delta = rad(delta)

	local n, cx, cy = self.m_n, self:Centroid()

	for i = 1, n do
		local apos = self[i]
		local dx, dy = apos.x - cx, apos.y - cy
		local radius, to = sqrt(dx^2 + dy^2), atan2(dy, dx) + delta

		apos.x, apos.y = cx + radius * cos(to), cy + radius * sin(to)
	end

	Refresh(self, n)
end

--- DOCME
function Shape:Scale (scale)
	local n, cx, cy = self.m_n, self:Centroid()

	for i = 1, n do
		local vpos = self[i]
		local dx, dy = vpos.x - cx, vpos.y - cy

		vpos.x, vpos.y = cx + scale * dx, cy + scale * dy
	end

	Refresh(self, n)
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
	local nam = RemoveMarks(v1, "m_angle_marks")
	local nas = RemoveMarks(v1, "m_side_marks")

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
	local style, w, px, py = v1.m_style, 5, AwayFromSide(S, index)

	if style == "a_to_b" or style == "b_to_a" then
		v1.m_object = display.newLine(S.m_side_group, arrows.GetPoints(v1, v2, px, py, .9, style == "b_to_a"))
	elseif style ~= "hide" then
		v1.m_object = display.newLine(S.m_side_group, v1.x, v1.y, v2.x, v2.y)

		if style == "dashed" then
			local stroke = v1.m_object.stroke

			stroke.effect, w = "filter.geometry_kit.dashes", 2
		end
	else
		v1.m_object = nil
	end

	--
	-- TODO: If offset, push side away by offset * px,py
	if style ~= "hide" then
		v1.m_object.strokeWidth = w

		color.ApplyColor(v1.m_object, "m_color", v1, v2)
	end
end

--
local function UpdateProp (k)
	return function(S, i, v)
		if S[i][k] ~= v then
			S[i][k] = v

			RedrawSide(S, i)
		end
	end
end

--- DOCME
-- @int side_index
-- @number[opt] offset
Shape.SetSideOffset = UpdateProp("m_offset")

-- --
local Styles = { a_to_b = true, b_to_a = true, dashed = true, hide = true }

--
local UpdateStyle = UpdateProp("m_style")

--- DOCME
-- @int side_index
-- @string[opt="normal"] style
function Shape:SetSideStyle (side_index, style)
	if not Styles[style] then
		style = "normal"
	end

	UpdateStyle(self, side_index, style)
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
function Shape:Translate (dx, dy)
	local n = self.m_n

	for i = 1, n do
		local v = self[i]

		v.x, v.y = v.x + dx, v.y + dy
	end

	Refresh(self, n)
end

--- DOCME
function M.Inherit (n)
	local mt = setmetatable({ m_n = n }, Shape)

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

-- Cache module members.
_NewShape_ = M.NewShape

-- Export the module.
return M