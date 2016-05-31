--- Circles, figure B-4.

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
local B3 = require("Circles.B3")

--
B3.A:Remove()
B3.T:Remove()

for i = 1, #B3.marks do
	B3.marks[i]:removeSelf()
end

--
for i = 1, 3 do
	B3.U:SetSideStyle(i, nil)
end

B3.U:Scale(1.5)
B3.U:Translate(20, 0)
B3.U:LabelAngle(1, "30°", { radius = 65, angle_time = .425 })
B3.U:LabelAngle(2, "60°", {radius = 45, angle_time = .45 })
B3.U:LabelSide(1, "1")
B3.U:LabelSide(2, "½", { text_offset = 25 })