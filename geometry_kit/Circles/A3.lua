--- Circles, figure A-3.

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

--
local A, A1, A2 = arc.New(), 20, 110

A:SetCenter(150, 200)
A:SetRadius(110)

local B = A:Clone()

A:SetAngles(A1, A2)
B:SetAngles(A2, A1)
B:SetStyle("dashed")

--
local x1, y1 = A:GetPos(0)
local x2, y2 = A:GetPos(1)
local cx, cy = A:GetCenter()

helpers.Point(cx, cy).path.radius = 5
helpers.Line(cx, cy, x1, y1, true)
helpers.Line(cx, cy, x2, y2, true)
helpers.Mark(x1, y1)
helpers.Mark(x2, y2)