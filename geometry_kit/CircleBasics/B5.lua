--- Circles, figure B-5.

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

T:SetVertexPos(1, 70, 200)
T:SetVertexPos(2, 200, 70)
T:SetVertexPos(3, 200, 200)

--
T:LabelSide(1, "1")

for i = 2, 3 do
	T:MarkAngle(i - 1, 1, { angle_offset = .15 + (i - 2) * .07 })
	T:MarkSide(i, 1)
end

T:MarkAngle(3, 1, { angle_offset = .15 })

--
local A = arc.New()

A:Revolve(T)
A:SetAngles(0, 90)
A:SetStyle("dashed")

--
local x1, y = A:GetCenter()
local x2, _ = A:GetPos(1)

helpers.HLine(x1, x2, y, true)