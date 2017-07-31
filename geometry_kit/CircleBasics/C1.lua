--- Circles, figure C-1.

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
local helpers = require("helpers")
local B1 = require("Circles.B1")

--
B1.U:Remove()

for i = 1, #B1.marks do
	B1.marks[i]:removeSelf()
end

for i = 2, 3 do
	B1.T:LabelSide(i, nil)
end

B1.T:MarkAngle(1, 1, { angle_offset = .15 })
B1.T:LabelAngle(1, "θ")

--
B1.A:Revolve(B1.T)

--
local x, y = B1.T:GetVertexPos(1)

helpers.Line(x, y, B1.P.x, B1.P.y, true)

--
helpers.Text("(x, y)", B1.P.x + 5, B1.P.y - 22)