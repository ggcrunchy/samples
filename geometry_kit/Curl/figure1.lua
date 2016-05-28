--- Curl, figure 1.

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

-- --
local CX, CY = 100, 300

--
local A, R = arc.New(), 110

A:SetRadius(R)
A:SetCenter(CX, CY)
A:SetAngles(270, 360)

local x1, y1 = A:GetPos(1)

helpers.Line(x1 + 1, y1 + 1, x1 - 70, y1 + 1)

--
local B = A:Clone()

B:SetAngles(270, 330)
A:SetStyle("dashed")

--
local C = B:Clone()

C:SetRadius(R + 10)
C:SetAngles(285, 315)

--
local lx, ly = C:GetPos(.5)
local dx, dy = lx - CX, ly - CY

helpers.Line(lx, ly, lx + dx * .4, ly + dy * .4)
helpers.Text("Rθ", lx + dx * .525, ly + dy * .525).rotation = -32.1

--
local T = triangle.New()
local XR, YR = B:GetPos(0)
local XL, YL = B:GetPos(1)

T:SetVertexPos(1, CX, CY)
T:SetVertexPos(2, XR, YR)
T:SetVertexPos(3, XL, YL)

T:MarkAngle(1, 1, { angle_offset = .2 })
T:LabelAngle(1, "θ")
T:SetSideStyle(2, "hide")

--
local angle = B:GetAngle_Radians()
local D = A:GetRadius() * (angle - math.sin(angle))

--
helpers.TextBelow_Multi({
	"R sinθ", XR,
	"D", XR + D
}, XL, CY - 20, -15, { size = 18 })
helpers.HLine(x1, XR + D, y1, true)
helpers.Tick(XR + D, y1)