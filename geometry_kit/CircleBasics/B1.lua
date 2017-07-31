--- Circles, figure B-1.

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
local T = triangle.New()

T:SetVertexPos(1, 30, 330)
T:SetVertexPos(2, 130, 230)
T:SetVertexPos(3, 130, 330)

--
local U = helpers.SimilarTriangleVertex(T, 1.9, 1)

for i = 1, 3 do
	U:SetSideStyle(i, "dashed")
end

U:LabelAngle(1, "θ", { radius = 40 })
U:LabelSide(1, "r", { align = true, t = .6, text_offset = 42 })
U:LabelSide(2, "y", { text_offset = 22 })
U:LabelSide(3, "x", { text_offset = 53 })
U:MarkAngle(1, 1, { angle_offset = .1 })
U:MarkAngle(3, 1)

--
local marks = {}

local function PutBetween (...)
	for _, mark in ipairs{ helpers.PutRotatedObjectBetween(...) } do
		marks[#marks + 1] = mark
	end
end

--
local x1, _ = U:GetVertexPos(1)
local x2, _ = U:GetVertexPos(2)

PutBetween(U:GetSideLabel(1), x1, x2 - .5, { margin = -4 })
PutBetween(U:GetSideLabel(3), x1, x2 - .5)

--
T:LabelSide(1, "1", { align = true, text_offset = 20 })
T:LabelSide(2, "y / r", { text_offset = 29 })
T:LabelSide(3, "x / r")

--
local x3, _ = T:GetVertexPos(3)

PutBetween(T:GetSideLabel(1), x1, x3, { margin = -4 })
PutBetween(T:GetSideLabel(3), x1, x3)

--
local A = arc.New()

A:Revolve(U)
A:SetAngles(0, 90)
A:SetStyle("dashed")

--
local P = helpers.Point(U:GetVertexPos(2))

P.path.radius = 6

--
return { A = A, T = T, U = U, P = P, marks = marks }