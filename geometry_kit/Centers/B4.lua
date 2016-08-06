--- Centers, figure B-4.

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
local triangle = require("triangle")
local E2 = require("Circles.E2")

--
for i = 1, #E2.marks do
	E2.marks[i]:removeSelf()
end

--
E2.T:LabelAngle(1, "2α")
E2.T:LabelSide(1, "r")

E2.U:LabelAngle(2, "α")
E2.U:LabelSide(1, nil)
E2.U:LabelSide(2, "A")
E2.U:LabelSide(3, "Asinα")

--
local x2, x3 = E2.U:GetVertexPos(1), E2.U:GetVertexPos(3)

helpers.PutRotatedObjectBetween(E2.U:GetSideLabel(3), x2 - .5, x3)