--- Circles, figure B-3.

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
local angle = math.rad(30)
local vx, vy = math.cos(angle), math.sin(angle)
local CX, CY, R = 70, 200, 160
local x2, y2 = CX + R * vx, CY - R * vy

--
local T = triangle.New()

T:SetVertexPos(1, CX, CY)
T:SetVertexPos(2, x2, y2)
T:SetVertexPos(3, x2, 2 * CY - y2)

--
local U = T:Clone()

--
for i = 1, 3 do
	T:MarkAngle(i, 1, { angle_offset = .15 })
end

--
T:LabelSide(1, "r")
T:LabelSide(3, "r")

--
U:SetVertexPos(3, x2, CY)

U:MarkAngle(3, 1, { angle_offset = .1 })
U:SetSideStyle(1, "hide")
U:SetSideStyle(2, "hide")
U:SetSideStyle(3, "dashed")

--
U:LabelSide(2, "½·r", { text_offset = 65 })

local vline = helpers.VLine(U:GetSideLabel(2).x - 25, CY, y2)
local marks = {
	vline,
	helpers.HLine(vline.x - 10, vline.x + 10, CY),
	helpers.HLine(vline.x - 10, vline.x + 10, y2)
}

--
local A = arc.New()

A:Revolve(T)
A:SetAngles(0, 90)
A:SetStyle("dashed")

--
marks[#marks + 1] = helpers.HLine(x2, CX + R, CY, true)

--
return { A = A, T = T, U = U, marks = marks }