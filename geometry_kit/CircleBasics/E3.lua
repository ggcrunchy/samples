--- Circle basics, figure E-3.

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

--
local CX, CY = 70, 200

--
local T = triangle.New()

T:SetVertexPos(1, CX, CY)
T:SetVertexPos(2, CX, CY - 80)
T:SetVertexPos(3, CX + 200, CY - 80)

local U = T:Clone()

T:LabelAngle(1, "90° - θ")
T:LabelSide(1, "sinθ", { align = true })
T:LabelSide(2, "cosθ")

local label = T:GetAngleLabel(1)
local lx, ly = label.x, label.y

label.y = ly + 70

local outline = display.newRoundedRect(lx, label.y, label.width + 7, label.height + 9, 12)
local line = display.newLine(lx, label.y - outline.height / 2, lx - 7, ly + 13)

outline:setFillColor(0, 0)

for _, object in ipairs{ outline, line } do
	object:setStrokeColor(.3)

	object.strokeWidth = 3
end

U:SetVertexPos(2, T:GetVertexPos(3))
U:SetVertexPos(3, T:GetVertexPos(3), CY)

U:SetSideStyle(1, "hide")
U:SetSideStyle(2, "dashed")
U:SetSideStyle(3, "dashed")
U:LabelAngle(1, "θ", { radius = 70 })
U:MarkAngle(1, 1, { angle_offset = .225 })
U:MarkAngle(3, 1, { angle_offset = .075 })