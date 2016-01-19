--- Triangles, figure C-4.

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
local math2d_ex = require("math2d_ex")
local side = require("side")

-- --
local CW, CH = display.contentWidth, display.contentHeight
local BottomY = .55 * CH
local MidY = .4 * CH
local TopY = .25 * CH
local LeftX = .15 * CW
local MidX = .25 * CW
local RightX = .35 * CW

--
local T = triangle.New()

T:SetVertexPos(1, MidX, TopY)
T:SetVertexPos(2, RightX, MidY)
T:SetVertexPos(3, LeftX, BottomY)

T:LabelSide(3, "D", { align = true, text_offset = 15 })
T:MarkAngle(3, 1, { angle_offset = .2 })

T:LabelSide(2, "?")

local Qmark = T:GetSideLabel(2)

local function Diff (dx, dy, scale)
	local U = T:Clone()
	local x2, y2 = T:GetVertexPos(2)
	local x3, y3 = T:GetVertexPos(3)

	U:SetVertexPos(2, math2d_ex.AddScaled(x3, y3, x2 - x3, y2 - y3, scale))
	U:Translate(dx, dy)
	U:LabelSide(2, nil)

	local cx, cy = U:Centroid()
	local to = { x = cx, y = cy }
	local ax, ay = side.Perp(Qmark, to)
	local pointer = display.newLine(arrows.GetPoints(Qmark, to, ax, ay, .9))

	pointer.strokeWidth = 3
	
	pointer:setStrokeColor(.2, .4)
end

Diff(40, 190, .7)
Diff(140, 50, 1.8)
Diff(85, -60, 2.3)