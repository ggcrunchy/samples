--- Triangles, figure D-1.

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
local figure10 = require("Triangles.C3")
local math2d_ex = require("math2d_ex")

local function Mark (x, y)
	local mark = display.newCircle(x, y, 5)

	mark:setFillColor(.3)
	mark:setStrokeColor(0)

	mark.strokeWidth = 4
end

local function Etch (from, name1, name2)
	local new = triangle.New()

	local x1, y1 = from:GetVertexPos(1)
	local x2, y2 = from:GetVertexPos(2)
	local x3, y3 = from:GetVertexPos(3)
	local x4, y4 = math2d_ex.AddScaled(x3, y3, x2 - x3, y2 - y3, .75)
	local x5, y5 = math2d_ex.AddScaled(x3, y3, x1 - x3, y1 - y3, .5)

	new:SetVertexPos(1, x3, y3)
	new:SetVertexPos(2, x4, y4)
	new:SetVertexPos(3, x5, y5)

	Mark(x4, y4)
	Mark(x5, y5)

	from:LabelSide(3, name1, { t = .5 })
	from:LabelSide(2, name2, { t = .25 })
end

Etch(figure10.T1, "p1", "p2")
Etch(figure10.T2, "q1", "q2")