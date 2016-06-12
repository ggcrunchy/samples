--- Circles, figure R-3.

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
local A, CX, CY, R = arc.New(), 150, 200, 120

A:SetCenter(CX, CY)
A:SetRadius(R)

local x3, y3 = A:GetPos(.35)

helpers.Point(x3, y3).path.radius = 6

A:SetAngles(340, 110)

local x1, y1 = A:GetPos(0)
local x2, y2 = A:GetPos(1)

--
local T1 = triangle.New()

T1:SetVertexPos(1, CX, CY)
T1:SetVertexPos(2, x1, y1)
T1:SetVertexPos(3, x2, y2)

T1:LabelAngle(1, "2α", { radius = 25 })
T1:LabelSide(2, "A", { align = true, text_offset = 17 })

--
local T2 = triangle.New()

T2:SetVertexPos(1, CX, CY)
T2:SetVertexPos(2, x3, y3)
T2:SetVertexPos(3, x1, y1)

T2:LabelAngle(1, "2β", { radius = 25 })
T2:LabelSide(2, "B", { align = true, text_offset = 17 })

--
local T3 = triangle.New()

T3:SetVertexPos(1, CX, CY)
T3:SetVertexPos(2, x2, y2)
T3:SetVertexPos(3, x3, y3)

T3:LabelAngle(1, "2γ", { radius = 25 })
T3:LabelSide(2, "C", { align = true, text_offset = 17 })

--
for i = 1, 3 do
	T1:SetSideStyle(i, i == 2 and "normal" or "dashed")
	T2:SetSideStyle(i, i == 2 and "normal" or "dashed")
	T3:SetSideStyle(i, i == 2 and "normal" or "hide")
end

--
A:SetAngles(0, 360)
A:SetStyle("dashed")

helpers.Point(x1, y1).path.radius = 6
helpers.Point(x2, y2).path.radius = 6
helpers.Point(x3, y3).path.radius = 6
helpers.Mark(CX, CY)
