--- Circles, figure F-1.

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
local D1 = require("Circles.D1")

--
D1.above:LabelSide(2, nil)
D1.above:MarkAngle(3, nil)
D1.below:LabelAngle(1, nil)
D1.below:MarkAngle(1, nil)
D1.below:MarkAngle(3, nil)

for i = 1, 3 do
	D1.below:SetSideStyle(i, "dashed")
end

for i = 1, 2 do
	D1.marks[i]:removeSelf()
end

--
local T, x1, y1 = D1.above:Clone(), D1.above:GetVertexPos(1)

T:SetVertexPos(3, D1.above:GetVertexPos(2), y1)

T:LabelAngle(1, "α", { angle_time = .7 })
T:MarkAngle(1, 1, { angle_offset = .15 })
T:MarkAngle(3, 1, { angle_offset = .15 })

for i = 1, 3 do
	D1.above:SetSideStyle(i, i == 1 and "hide" or "dashed")
end

--
local label = D1.above:GetAngleLabel(1)

label:translate(-30, -50)

helpers.Line(label.x + 2, label.y + 12, x1 + 13, y1 - 16):setStrokeColor(.3)

local diff = helpers.Text("α - β", x1 + 35, y1 + 55)

helpers.Line(diff.x + 2, diff.y - 6, x1 + 24, y1 - 7):setStrokeColor(.3)