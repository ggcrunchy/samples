--- Circles, figure E-1.

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
local degs, x1, y1, R = 35, 50, 350, 220
local angle = math.rad(degs)
local vx, vy = math.cos(2 * angle), math.sin(2 * angle)
local upper, lower = helpers.RotatedRightTriangle(x1, y1, x1 + R * vx, y1 - R * vy, degs, {
	angle_label = "θ", radius = 45, show_right_angle = true
}, {
	angle_label = "θ", radius = 45
})

upper:LabelSide(2, "sinθ", { align = true, text_offset = 15 })

--
local T = triangle.New()

T:SetVertexPos(1, x1, y1)
T:SetVertexPos(2, upper:GetVertexPos(3))
T:SetVertexPos(3, x1 + R, y1)

for i = 1, 3 do
	T:SetSideStyle(i, i == 1 and "hide" or "dashed")
end

--
local A = arc.New()

A:Revolve(upper)
A:SetAngles(0, 90)
A:SetStyle("dashed")

--
local marks = {
	helpers.Mark(T:GetVertexPos(2)),
	helpers.Mark(T:GetVertexPos(3))
}

--
return { A = A, T = T, upper = upper, lower = lower, marks = marks }