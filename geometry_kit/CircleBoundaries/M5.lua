--- Circles, figure M-5.

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
local arc = require("arc")
local helpers = require("helpers")
local triangle = require("triangle")

--
local A1, CX, CY = arc.New(), 160, 200

A1:SetCenter(CX, CY)
A1:SetRadius(135)

--
local x, y = A1:GetPos(.125)
local dx, dy = x - CX, y - CY

--
local A2, R2 = arc.New(), 35
local N = R2 / math.sqrt(dx^2 + dy^2)

A2:SetCenter(x - dx * N, y - dy * N)
A2:SetRadius(R2)

--
local T, CX2, CY2 = triangle.New(), A2:GetCenter()

T:SetVertexPos(1, CX, CY)
T:SetVertexPos(2, A1:GetPos(.8))
T:SetVertexPos(3, CX2, CY2)

T:LabelSide(1, "r1", { align = true, text_offset = 20 })
T:LabelSide(3, "r1 - r2")
T:SetSideStyle(1, "dashed")
T:SetSideStyle(2, "hide")
T:SetSideStyle(3, "dashed")

--
local label = T:GetSideLabel(3)

label:translate(-50, 20)

local rect = display.newRoundedRect(label.x, label.y, label.width + 7, label.height + 5, 15)

rect:setFillColor(0, 0)

rect.strokeWidth = 3

local dcx, dcy = CX2 - CX, CY2 - CY
local lx, ly = CX + .5 * dcx - 5, CY + .5 * dcy + 5
local line = helpers.Line(label.x + label.width * .475 - .5, rect.y - .575 * rect.height / 2, lx, ly)
local mark = helpers.Line(lx - dcx * .4, ly - dcy * .4, lx + dcx * .4, ly + dcy * .4)

for _, object in ipairs{ rect, line, mark } do
	object:setStrokeColor(.3)
end

--
helpers.Point(CX, CY).path.radius = 4
helpers.Point(A2:GetCenter()).path.radius = 4