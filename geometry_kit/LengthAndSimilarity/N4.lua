--- Triangles, figure N-4.

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

-- --
local CW, CH = display.contentWidth, display.contentHeight

--
local P = display.newCircle(.2 * CW, .2 * CH, 12)
local Q = display.newCircle(P.x + .6 * CW, P.y + .1 * CH, 12)
local R = display.newCircle(P.x + .2 * CW, P.y + .5 * CH, 12)

P:setFillColor(0)
Q:setFillColor(0)
R:setFillColor(0)

local StrP = display.newText("p", P.x - 3, P.y - 35, native.systemFontBold, 22)
local StrQ = display.newText("q", Q.x + 13, Q.y - 35, native.systemFontBold, 22)
local StrR = display.newText("r", R.x - 1, R.y + 30, native.systemFontBold, 22)

StrP:setTextColor(0)
StrQ:setTextColor(0)
StrR:setTextColor(0)

-- --
local T = triangle.New()

T:SetVertexPos(1, P.x, P.y)
T:SetVertexPos(2, Q.x, Q.y)
T:SetVertexPos(3, R.x, R.y)

local U = T:Clone()

U:Scale(.6)

local x, y = U:GetVertexPos(1)

U:Translate(P.x - x, P.y - y)

--
local PQ = triangle.New()

PQ:SetVertexPos(1, P.x, P.y)
PQ:SetVertexPos(2, Q.x, P.y)
PQ:SetVertexPos(3, Q.x, Q.y)

PQ:SetSideStyle(1, "dashed")
PQ:SetSideStyle(2, "dashed")
PQ:SetSideStyle(3, "hide")

local PQ2 = PQ:Clone()

PQ2:Scale(.61)

local x2, y2 = PQ2:GetVertexPos(1)

PQ2:Translate(P.x - x2, P.y - y2)
PQ2:SetSideStyle(1, "hide")
PQ:MarkAngle(2, 1, { angle_offset = .25 })

--
local PR = triangle.New()

PR:SetVertexPos(1, P.x, P.y)
PR:SetVertexPos(2, R.x, R.y)
PR:SetVertexPos(3, P.x, R.y)

PR:SetSideStyle(1, "hide")
PR:SetSideStyle(2, "dashed")
PR:SetSideStyle(3, "dashed")

local PR2 = PR:Clone()

PR2:Scale(.61)

local x3, y3 = PR2:GetVertexPos(1)

PR2:Translate(P.x - x3, P.y - y3)
PR2:SetSideStyle(1, "hide")
PR:MarkAngle(3, 1, { angle_offset = .05 })

--
for i = 2, 3 do
	local x2, y2 = U:GetVertexPos(i)
	local mark = display.newCircle(x2, y2, 5)

	mark:setFillColor(.3)
	mark:setStrokeColor(0)

	mark.strokeWidth = 4
end

T:SetSideStyle(1, "dashed")
T:SetSideStyle(2, "dashed")
T:SetSideStyle(3, "dashed")