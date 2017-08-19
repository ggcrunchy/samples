--- Similar triangles, figure D-5.

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
local D3 = require("SimilarTriangles.D3")

--
D3.U:SetSideStyle(2, "hide")

for _, k in ipairs{ "L", "U" } do
	D3[k]:MarkSide(1, 4, { angle_spacing = .075, side_mark_length = 13 })
	D3[k]:SetSideStyle(2, "hide")
	D3[k]:MarkAngle(2, nil)

	for i = 1, 3 do
		if i ~= 2 then
			D3[k]:MarkAngle(i, nil)
		end

		D3.D2[k]:MarkSide(1, nil)
	end

	for i = 1, 2 do
		D3.D2[k]:MarkAngle(i, nil)
		D3.D2[k]:SetSideStyle(1, "hide")
	end

	D3.D2.m1:removeSelf()
	D3.D2.m2:removeSelf()

	D3.D2[k]:MarkSide(2, nil)
end

for _, k in pairs{ "T", "U" } do
	D3.D2.D1[k]:MarkAngle(3, nil)
	D3.D2.D1[k]:MarkSide(2, nil)
end

D3.D2.D1.m:removeSelf()

--
local x, y = D3.D2.D1.T:GetVertexPos(1)

helpers.HLine(x, x + 100, y, true)
helpers.Mark(x, y)

D3.D2.D1.T:LabelAngle(1, "α", { radius = 50 })
D3.D2.D1.U:LabelAngle(1, "β", { radius = 50 })

helpers.Mark(D3.L:GetVertexPos(2))