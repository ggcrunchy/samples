--- Circles, figure D-1.

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
local angle = 30
local above, below = helpers.RotatedRightTriangle(40, 300, 130, 75, angle, {
	angle_label = "β", radius = 55, show_right_angle = true
}, {
	angle_label = "α", angle_marks = 1, angle_offset = .17, radius = 60, angle_time = .6, show_right_angle = true
})

above:LabelSide(2, "sinβ", { align = true, text_offset = 20 })

--
local A = arc.New()

A:Revolve(above)
A:SetAngles(0, 90)
A:SetStyle("dashed")

--
local marks = {}

for i = 2, 3 do
	marks[#marks + 1] = helpers.Mark(above:GetVertexPos(i))
end

return { above = above, below = below, marks = marks, A = A }