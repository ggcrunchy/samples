--- Curl, figure 4.

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

--- Modules --
local arc = require("arc")
local helpers = require("helpers")
local triangle = require("triangle")

-- --
local CX, CY = 150, 300

--
local A, A2 = arc.New(), 40

A:SetRadius(70)
A:SetCenter(CX - 50, CY)
A:SetAngles(270, A2)

--
local B = A:Clone()

B:SetAngles(A2, 90)
B:SetStyle("dashed")

local R, x1, y1 = A:GetRadius(), A:GetPos(1)
local x2, y2 = A:GetPos(0)

local T = triangle.New()

T:SetVertexPos(1, A:GetCenter())
T:SetVertexPos(2, x2, y2)
T:SetVertexPos(3, x1, CY - R)

T:SetSideStyle(1, "hide")
T:SetSideStyle(2, "hide")
T:SetSideStyle(3, "dashed")
T:LabelAngle(1, "θ")
T:MarkAngle(1, 2, { angle_offset = .225, angle_spacing = .1 })

--
local U = triangle.New()

U:SetVertexPos(1, A:GetCenter())
U:SetVertexPos(2, x1, y1)
U:SetVertexPos(3, x2, y2)

U:MarkAngle(1, 1, { angle_offset = .2 })
U:LabelAngle(1, "α")
U:SetSideStyle(2, "hide")

--
helpers.TextBelow("R sinθ", x1, x2 + .5, CY - R - 20, -12, { size = 15 })
helpers.TextBetween("R", x1, x1 + R + .5, CY + R + 20, { margin = 3, size = 18 })