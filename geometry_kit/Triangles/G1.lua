--- Triangles, figure G-1.

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
local triangle = require("triangle")
local arrows = require("arrows")
local side = require("side")

-- Kernels --
require("kernels")

-- Plugins --
local math2d = require "plugin.math2d"

-- --
local CW, CH = display.contentWidth, display.contentHeight

--
local X1, Y1 = .15 * CW, .1 * CH
local Angle = math.rad(17)
local CosA, SinA = math.cos(Angle), math.sin(Angle)
local NX, NY = math2d.normals(CosA, SinA)
local ToX, ToY = math2d.scale(NX, NY, .22 * CH)

--
local function Pos (offset, below)
	offset = offset * CW

	local x, y = X1 + offset * CosA, Y1 + offset * SinA

	if below then
		x, y = x + ToX, y + ToY
	end

	return x, y
end

-- todo: line 1 - two points, normalize, scale
local function NewLine (from, to, below)
	local x1, y1 = Pos(from, below)
	local x2, y2 = Pos(to, below)
	local line = display.newLine(x1, y1, x2, y2)

	if below then
		line.stroke.effect = "filter.geometry_kit.dashes"
	end

	line.strokeWidth = 4

	line:setStrokeColor(0)
end

local Mid, End = .06, .275

local a, b

for i = 1, 2 do
	NewLine(0, .8, i == 2)

	local offset = .03 + (i - 1) * .45
	local T = triangle.New()

	for j, plus in ipairs{ 0, End, Mid } do
		local x, y = Pos(offset + plus, j == 3)

		T:SetVertexPos(j, x, y)

		local mark = display.newCircle(x, y, 5)

		mark:setFillColor(.3)
		mark:setStrokeColor(0)

		mark.strokeWidth = 4
	end

	T:MarkAngle(2, 1, { angle_offset = .15 })
	T:MarkSide(1, 1)
	T:MarkSide(2, 2)
	T:SetSideStyle(3, "dashed")

	local cx, cy = T:Centroid()
	local p = { x = cx, y = cy }

	if a then
		b = p
	else
		a = p
	end
end

local ax, ay = side.Perp(a, b)
local pointer = display.newLine(arrows.GetPoints(a, b, ax, ay, .9))

pointer.strokeWidth = 3

pointer:setStrokeColor(.2, .4)